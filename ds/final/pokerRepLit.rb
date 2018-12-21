require 'wit'

class Player
  
  attr_accessor :name, :chips, :pocket
  
  def initialize
    @name = ""
    @chips = 1000
    @pocket = []
  end
end

module HandCalculator

  def r(cards)
    cards.map(&:to_i).sort
  end


  def s(cards)
    cards.map { |card| card[-1] }
  end

  
  def which_rank_occurs_n_times?(cards, n)
    return cards.select { |x| cards.count(x) == n }.uniq
  end

  
  def assess_kickers(hands, i)
          
    best_hand = [], kicker = 0

    hands.each do |hand_unrefined|
      nonpair_cards = which_rank_occurs_n_times?(r(hand_unrefined), 1)
          
      if nonpair_cards[i] > kicker
        kicker = nonpair_cards[i]
        best_hand = [hand_unrefined]
          
      elsif nonpair_cards[i] == kicker
        best_hand << hand_unrefined
      end
    end
        
    return best_hand.length == 1 || i == 0 ? best_hand : assess_kickers(best_hand, i -= 1)
  end

  
  def all_hands_from_cards(cards)

    all_hands = []
    
    if cards.length == 7
      until all_hands.length == 21
        cards = cards.shuffle
        random_hand = cards[0..4]
        all_hands << random_hand.sort
        all_hands = all_hands.uniq
      end
    elsif cards.length == 6
      until all_hands.length == 6
        cards = cards.shuffle
        random_hand = cards[0..4]
        all_hands << random_hand.sort
        all_hands = all_hands.uniq
      end
    else return [cards]
    end
    
    return all_hands
  end

  
  def deduce_best_hand(arr, hands, best_hand = [], best_hand_score = nil)
    
    arr.each_with_index.inject(0) do |max_val, (val, index)|
      if val > max_val
        best_hand_score = val if best_hand_score
        best_hand = [hands[index]]
        val
      elsif val == max_val
        best_hand.push(hands[index])
        val
      else
        max_val
      end
    end
  
    return best_hand_score ? [best_hand, best_hand_score] : best_hand
  end

  
  def straight_flush(r, s)

    if s[0] == s[1] && s[1] == s[2] && s[2] == s[3] && s[3] == s[4]
      
      if r[4] - r[3] == 1 && r[3] - r[2] == 1 && r[2] - r[1] == 1 && r[1] - r[0] == 1 &&  r[3] == 13
        "royal flush"
      elsif r[4] - r[3] == 1 && r[3] - r[2] == 1 && r[2] - r[1] == 1 && r[1] - r[0] == 1
        true
      elsif r[3] - r[2] == 1 && r[2] - r[1] == 1 && r[1] - r[0] == 1 && r[4] - r[0] == 12 && r[4] == 14
        true
      else false
      end
    else false
    end
  end


  def quads(r)
    
    if (r[0] == r[1] && r[1] == r[2] && r[2] == r[3]) || (r[1] == r[2] && r[2] == r[3] && r[3] == r[4])
      true
    else false
    end
  end


  def full_house(r)

    if ((r[0] == r[1] && r[1] == r[2]) && r[3] == r[4]) || (r[0] == r[1] && (r[2] == r[3] && r[3] == r[4]))
      true
    else false
    end
  end


  def flush(s)
    
    if s[0] == s[1] && s[1] == s[2] && s[2] == s[3] && s[3] == s[4]
      true
    else false
    end
  end


  def straight(r)
    
    if r[4] - r[3] == 1 && r[3] - r[2] == 1 && r[2] - r[1] == 1 && r[1] - r[0] == 1
      true
    elsif r[3] - r[2] == 1 && r[2] - r[1] == 1 && r[1] - r[0] == 1 && r[4] - r[0] == 12 && r[4] == 14
      true
    else false
    end
  end


  def trips(r)

    if (r[0] == r[1] && r[1] == r[2]) || (r[1] == r[2] && r[2] == r[3]) || (r[2] == r[3] && r[3] == r[4])
      true
    else false
    end
  end


  def two_pair(r)
    
    if (r[0] == r[1] && r[2] == r[3]) || (r[1] == r[2] && r[3] == r[4]) || (r[0] == r[1] && r[3] == r[4])
      true
    else false
    end
  end


  def pair(r)
    
    if r[0] == r[1] || r[1] == r[2] || r[2] == r[3] || r[3] == r[4]
      true
    else false
    end
  end


  def best_quads(hands, already_called = false)

    rank_arrs = hands.map(&method(:r))
    
    if !already_called
      quad_cards = rank_arrs.map { |hand| which_rank_occurs_n_times?(hand, 4) }.flatten
      best_hand = deduce_best_hand(quad_cards, hands)
      return best_hand.length == 1 ? best_hand : best_quads(best_hand, true)
    end
    
    return assess_kickers(hands, 0)
  end


  def best_full_house(hands, compare = "trips")
  
    rank_arrs = hands.map(&method(:r))
    
    if compare == "trips"
      trip_cards = rank_arrs.map { |hand| which_rank_occurs_n_times?(hand, 3) }.flatten
      best_hand = deduce_best_hand(trip_cards, hands)
      return best_hand.length == 1 ? best_hand : best_full_house(best_hand, "pair")
    end
    
    pair_cards = rank_arrs.map { |hand| which_rank_occurs_n_times?(hand, 2) }.flatten
    
    return deduce_best_hand(pair_cards, hands)
  end


  def best_flush(hands)
    return assess_kickers(hands, 4)
  end


  def best_straight(hands)
      
    rank_arrs = hands.map(&method(:r))
    
    rank_sums = rank_arrs.map do |rank_arr|
      rank_arr[4] = 1 if (rank_arr[4] == 14 && rank_arr[0] == 2)
      rank_arr.inject(:+)
    end
    
    return deduce_best_hand(rank_sums, hands)
  end


  def best_trips(hands)
    
    rank_arrs = hands.map(&method(:r))
    trip_cards = rank_arrs.map { |hand| which_rank_occurs_n_times?(hand, 3) }.flatten
    best_hand = deduce_best_hand(trip_cards, hands)

    return best_hand.length == 1 ? best_hand : assess_kickers(best_hand, 1)
  end


  def best_two_pair(hands, compare = "top_pair")

    rank_arrs = hands.map(&method(:r))
    
    if compare == "top_pair"
      top_pairs = rank_arrs.map { |rank_arr| which_rank_occurs_n_times?(rank_arr, 2).max }
      best_hand = deduce_best_hand(top_pairs, hands)
      return best_hand.length == 1 ? best_hand : best_two_pair(best_hand, "bottom_pair")
    end
    
    if compare == "bottom_pair"
      bottom_pairs = rank_arrs.map { |rank_arr| which_rank_occurs_n_times?(rank_arr, 2).min }
      best_hand = deduce_best_hand(bottom_pairs, hands)
      return best_hand.length == 1 ? best_hand : best_two_pair(best_hand, "kickers")
    end
    
    return assess_kickers(hands, 0)
  end


  def best_pair(hands)
    
    rank_arrs = hands.map(&method(:r))
    pair_cards = rank_arrs.map { |hand| which_rank_occurs_n_times?(hand, 2) }.flatten
    best_hand = deduce_best_hand(pair_cards, hands, best_hand)
    
    return best_hand.length == 1 ? best_hand : assess_kickers(best_hand, 2)
  end


  def best_air(hands)
    return assess_kickers(hands, 4)
  end


  def winning_hand(hand)
    
    # note: the below hand processing statement is not needed for the console version of game.
    #hand = hand.length == 1 ? hand.flatten : hand[0]

    return "ROYAL FLUSH!" if straight_flush(r(hand), s(hand)) == "royal flush"
    return "STRAIGHT FLUSH!" if straight_flush(r(hand), s(hand))
    return "FOUR OF A KIND!" if quads(r(hand))
    return "FULL HOUSE!" if full_house(r(hand))
    return "FLUSH!" if flush(s(hand))
    return "STRAIGHT!" if straight(r(hand))
    return "THREE OF A KIND!" if trips(r(hand))
    return "TWO PAIR!" if two_pair(r(hand))
    return "PAIR!" if pair(r(hand))
    return "COMPLETE AIR"
  end


  def evaluate_hand(cards)
    return 9 if straight_flush(r(cards), s(cards)) == "royal flush"
    return 8 if straight_flush(r(cards), s(cards))
    return 7 if quads(r(cards))
    return 6 if full_house(r(cards))
    return 5 if flush(s(cards))
    return 4 if straight(r(cards))
    return 3 if trips(r(cards))
    return 2 if two_pair(r(cards))
    return 1 if pair(r(cards))
    return 0
  end


  def best_hand(hands)

    hand_scores = hands.map { |hand| evaluate_hand(hand) }
    best_arr = deduce_best_hand(hand_scores, hands, [], 0)
    best_hand = best_arr[0]
    best_hand_score = best_arr[1]
    
    return best_hand if (best_hand.length == 1 || best_hand_score == 9)   
    
    tie_breaker_methods_arr = [method(:best_air), method(:best_pair), method(:best_two_pair),
                              method(:best_trips), method(:best_straight), method(:best_flush), 
                              method(:best_full_house), method(:best_quads), method(:best_straight)]
    
    return tie_breaker_methods_arr[best_hand_score].call(best_hand)
  end
  
  def visual(cards)

    ordered_deck = ("2".."14").flat_map { |rank| ("a".."d").map { |suit| (rank + suit) } }
    
    card_hash = { "2" => " 2", "3" => " 3", "4" => " 4", "5" => " 5", "6" => " 6", "7" => " 7", 
      "8" => " 8", "9" => " 9", "10" => "10", "11" => "J ", "12" => "Q ", "13" => "K ", "14" => "A " }
    suits = [ "♦", "♥", "♣", "♠" ]
    to_put = ""
    
    i = 0
    while i < 4
      j = 0
      while j < cards.size
        if i == 0
          to_put += " ______"
        elsif i == 1
          to_put += "|#{suits[ordered_deck.index(cards[j]) % 4 ]}    |"
        elsif i == 2
          if cards[j].to_i < 10 
            to_put += "| #{card_hash[cards[j][0]]}  |"
          elsif cards[j].to_i >= 10
            to_put += "|  #{card_hash[cards[j][0..1]]} |"
          end
        elsif i == 3
          to_put += "|____#{suits[ordered_deck.index(cards[j]) % 4 ]}|" 
        end
        j += 1
      end
      to_put += "\n"
      i += 1
    end
    puts to_put
  end
  
end

class Game
  
  include HandCalculator
    
  attr_accessor :deck, :pot, :button_player, :other_player, :community_cards, :bp_bet, :op_bet
  
  def initialize
      @deck = []
      @pot = 0
      @button_player = Player.new
      @other_player = Player.new
      @community_cards = []
      @bp_bet = 0
      @op_bet = 0
      begin_game()
  end
  
  def begin_game
    if @button_player.name == ""
      puts "."
      sleep(0.35)
      puts "."
      sleep(0.35)
      puts "."
      sleep(0.35)
      puts "Welcome to Sam Hickey's Poker Madness!\n\n"
      sleep(2)
      puts "Let's begin!"
      sleep(1.25)
      puts "\n"
      puts "What is player 1's name?"
      @button_player.name = gets.chomp.capitalize
      sleep(0.15)
      puts "\nAnd, what is player 2's name?"
      @other_player.name = gets.chomp.capitalize
      new_hand_notification()
    end
  end
  
  def community_deal
    @community_cards.length == 0 ? @community_cards = @deck.slice!(0,3) : @community_cards << @deck.shift
    if @community_cards.length == 3
      puts_cards("other")
      puts "#{@other_player.name}, the pot is now #{@pot}. You have #{@other_player.chips} chips left. Type b, c, or a"
      action = gets.chomp
      action, val = use_wit(action)
      determine_action(@other_player, action, val, "check/bet")
    elsif @community_cards.length == 4
      puts_cards("other")
      puts "#{@other_player.name}, the pot is now #{@pot}. You have #{@other_player.chips} chips left. Type b, c, or a"
      action = gets.chomp
      action, val = use_wit(action)
      determine_action(@other_player, action, val, "check/bet")     
    elsif @community_cards.length == 5
      puts_cards("other")
      puts "#{@other_player.name}, the pot is now #{@pot}. You have #{@other_player.chips} chips left. Type b, c, or a"
      action = gets.chomp
      action, val = use_wit(action)
      determine_action(@other_player, action, val, "check/bet")
    end
  end

  def use_wit(msg)
    client = Wit.new(access_token: 'ZODQGWIEJ7SPIJMP2CUEG7FWLHEVYRS7')
    package = client.message(msg)
    action = package['entities']['intent'][0]["value"][0]
    value = 0
    begin
      value = package['entities']['number'][0]["value"]
    rescue
      value = -1
    end
    return action, value
  end

  def use_wit_num(msg)
    client = Wit.new(access_token: 'ZODQGWIEJ7SPIJMP2CUEG7FWLHEVYRS7')
    package = client.message(msg)
    value = 0
    begin
      value = package['entities']['number'][0]["value"]
    rescue
      value = -1
    end
    puts(value)
    return value
  end
  
  def determine_action(player, action, val, type)
    if player == @other_player
      if type == "check/bet"
        if action == "c"
          check(@other_player)
        elsif action == "b"
          bet(@other_player, val)
        elsif action == "f"
          fold(@other_player)
        elsif action == "a"
          all_in(@other_player)
        end
      elsif type == "call/raise"
        if action == "c"
          call(@other_player)
        elsif action == "r"
          raze(@other_player, val)
        elsif action == "f"
          fold(@other_player)
        elsif action == "a"
          all_in(@other_player)
        end
      end
    elsif player == @button_player
      if type == "check/bet"
        if action == "c"
          check(@button_player)
        elsif action == "b"
          bet(@button_player, val)
        elsif action == "f"
          fold(@button_player)
        elsif action == "a"
          all_in(@button_player)
        end
      elsif type == "call/raise"
        if action == "c"
          call(@button_player)
        elsif action == "r"
          raze(@button_player, val)
        elsif action == "f"
          fold(@button_player)
        elsif action == "a"
          all_in(@button_player)
        end
      end
    end
  end

  def new_hand
    @other_player, @button_player = @button_player, @other_player
    @community_cards = []
    @deck = ("2".."14").flat_map { |rank| ("a".."d").map { |suit| (rank + suit) } }.shuffle
    @button_player.pocket = @deck.slice!(0,2)
    @other_player.pocket = @deck.slice!(0,2)
    @button_player.chips -= 10
    @other_player.chips -= 5
    @bp_bet = 10
    @op_bet = 5
    @pot = 15
    puts "\n\n"
    puts_cards("other")
    puts "#{@other_player.name}, you are out of position and first to act. You have #{@other_player.chips} chips. The pot is #{@pot}. #{@bp_bet - @op_bet} chips to call. What do you want to do? (c, f, r, or a)"
    action = gets.chomp
    action, val = use_wit(action)
    determine_action(@other_player, action, val,"call/raise")
  end

  def new_hand_notification
    sleep(0.5)
    puts "\n"
    puts "Dealing new hand..."
    sleep(0.60)
    print "Wait a moment"
    sleep(0.55)
    print "."
    sleep(0.55)
    print "."
    sleep(0.55)
    print "."
    sleep(0.55)
    print "."
    puts "\n"
    new_hand()
  end
  
  def see_river
    if @community_cards.length == 0
      @community_cards << @deck.slice!(0,5)
      @community_cards.flatten!
    elsif @community_cards.length == 3
      @community_cards << @deck.slice!(0,2)
      @community_cards.flatten!
    elsif @community_cards.length == 4
      @community_cards << @deck.slice!(0,1)
      @community_cards.flatten!
    end
  end
    
  def determine_winner
    op_best_hand = best_hand(all_hands_from_cards(@community_cards + @other_player.pocket)).length > 1 ? best_hand(all_hands_from_cards(@community_cards + @other_player.pocket))[0] : best_hand(all_hands_from_cards(@community_cards + @other_player.pocket)).flatten
    bp_best_hand = best_hand(all_hands_from_cards(@community_cards + @button_player.pocket)).length > 1 ? best_hand(all_hands_from_cards(@community_cards + @button_player.pocket))[0] : best_hand(all_hands_from_cards(@community_cards + @button_player.pocket)).flatten
    da_bestest = best_hand([op_best_hand.flatten, bp_best_hand.flatten]).length > 1 ? best_hand([op_best_hand.flatten, bp_best_hand.flatten]) : best_hand([op_best_hand.flatten, bp_best_hand.flatten]).flatten
    puts "The community cards are:\n\n"
    sleep(1)
    puts "Community cards: #{visual(@community_cards)}\n\n\n"
    sleep(2)
    puts "#{@other_player.name}'s pocket cards and best hand are:\n\n"
    sleep(1)
    puts "#{@other_player.name}'s pocket cards: #{visual(@other_player.pocket)}"
    puts "#{@other_player.name}'s best hand: #{winning_hand(op_best_hand)}#{visual(op_best_hand)}\n\n\n"
    sleep(2)
    puts "#{@button_player.name}'s pocket cards and best hand are:\n\n"
    sleep(1)
    puts "#{@button_player.name}'s pocket cards: #{visual(@button_player.pocket)}"
    puts "#{@button_player.name}'s best hand: #{winning_hand(bp_best_hand)}#{visual(bp_best_hand)}\n\n\n"
    sleep(2)
    puts "THE best hand IS:\n\n"
    sleep(1)

    
    if da_bestest == op_best_hand
      @other_player.chips += @pot
      puts "#{visual(da_bestest)} The best hand: #{@other_player.name}'s!\n\n\n"
      puts "#{@other_player.name}'s hand! #{@other_player.name} wins the pot with a #{winning_hand(op_best_hand)}\n\n\n"
      sleep(1.25)
      print "WOOHOO!"
      puts "\n\n\n"
      if game_over?()
        return
      else
        new_hand_notification()
      end
    elsif da_bestest == bp_best_hand
      @button_player.chips += @pot
      puts "#{visual(da_bestest)} The best hand: #{@button_player.name}'s!\n\n\n"
      puts "#{@button_player.name}'s hand! #{@button_player.name} wins the pot with a #{winning_hand(bp_best_hand)}\n\n\n"
      sleep(1.25)
      print "WOOHOO!"
      puts "\n\n\n"
      if game_over?()
        return
      else
        new_hand_notification()
      end
    else
      puts "Split pot!\n\n\n\n"
      @button_player.chips += @pot / 2
      @other_player.chips += @pot / 2
      sleep(1.25)
      puts "Let's divvy that pot up!"
      new_hand_notification()
    end
  end
  
  def determine_winner_notification(type)
    if type == "all-in"
      puts "All-in! To the river! Determining winner..."
      puts "."
      sleep(0.75)
      puts "."
      sleep(0.75)
      puts "."
      sleep(0.75)
      see_river()
      determine_winner()
    elsif type == "check/call"
      puts "Determining winner..."
      puts "."
      sleep(0.75)
      puts "."
      sleep(0.75)
      puts "."
      sleep(0.75)
      determine_winner()
    end
  end
  
  def game_over?
    if @button_player.chips < 10
      puts "Game over! #{@other_player.name}, you win!"
      return true
    elsif @other_player.chips < 10
      puts "Game over! #{@button_player.name}, you win!"
      return true
    end
  end
  
  def puts_cards(player)
    if player == "other"
      puts "\n\n"
      puts "#{visual(@community_cards)} ^^Community cards^^" unless @community_cards.empty?
      puts "#{visual(@other_player.pocket)}^Pocket cards^\n\n"
    elsif player == "button"
      puts "\n\n"
      puts "#{visual(@community_cards)} ^^Community cards^^" unless @community_cards.empty?
      puts "#{visual(@button_player.pocket)}^Pocket cards^\n\n"
    end
  end

  def check(player)
    if player == @other_player
      puts_cards("button")
      puts "#{@button_player.name}, #{@other_player.name} checked. The pot is #{@pot}. You have #{@button_player.chips} chips left. What would you like to do? (c, b, a)"
      action = gets.chomp
      action, val = use_wit(action)
      determine_action(@button_player, action, val, "check/bet")
    elsif player == @button_player
      if @community_cards.length == 5
        determine_winner_notification("check/call")
      else
        community_deal()
      end
    end
  end
  
  def fold(player)
    if player == @other_player
      @button_player.chips += @pot
      new_hand_notification()
    elsif player == @button_player
      @other_player.chips += @pot
      new_hand_notification()
    end
  end

  def call(player)
    if player == @other_player
      if @other_player.chips > (@bp_bet - @op_bet)
        @pot += (@bp_bet - @op_bet)
        @other_player.chips -= (@bp_bet - @op_bet)
        @op_bet = 0
        @bp_bet = 0
        #The second statement after && is to make sure the flop doesn't initiate before the button player has a chance to act
        if @button_player.chips == 0
          determine_winner_notification("all-in")
        elsif @community_cards.length < 5 && (@community_cards.length > 0 || @pot > 20)
          community_deal()
        elsif @pot == 20
          @op_bet = 10
          @bp_bet = 10
          puts_cards("button")
          puts "#{@button_player.name}, #{@other_player.name} limped in. You are on the button. What would you like to do? ( c, r, a)"
          action = gets.chomp
          action, val = use_wit(action)
          determine_action(@button_player, action, val, "call/raise")
        else
          determine_winner_notification("check/call")
        end
      else
        @pot += (@bp_bet - @op_bet)
        @other_player.chips = 0
        determine_winner_notification("all-in")
      end
    elsif player == @button_player
      if @button_player.chips > (@op_bet - @bp_bet)
        @pot += (@op_bet - @bp_bet)
        @button_player.chips -= (@op_bet - @bp_bet)
        @op_bet = 0
        @bp_bet = 0
        if @other_player.chips == 0
          determine_winner_notification("all-in")
        elsif @community_cards.length < 5
          community_deal()
        else
          determine_winner_notification("check/call")
        end
      else
        @pot += (@op_bet - @bp_bet)
        @button_player.chips = 0
        determine_winner_notification("all-in")
      end
    end
  end
  
  def bet(player, val)
    if player == @other_player
      bet_loop = true
      first_loop = true
      while bet_loop == true
        bet_amount = 0
        if val != -1 and first_loop
          first_loop = false
          bet_amount = val
        else
          puts "#{@other_player.name}, the pot is #{@pot}. How much would you like to bet?"
          bet_amount = gets.chomp
          bet_amount = use_wit_num(bet_amount)
        end
        if bet_amount > @button_player.chips
          @pot += @button_player.chips
          @other_player.chips -= @button_player.chips
          @op_bet = @button_player.chips
          bet_loop = false
          puts_cards("button")
          puts "#{@button_player.name}, #{@other_player.name} has put you all-in. Would you like to call? Type y or n"
          answer = gets.chomp
          action, val = use_wit(action)
          if answer == "y"
            call(@button_player)
            bet_loop = false
          elsif answer == "n"
            fold(@button_player)
            bet_loop = false
          end
        elsif bet_amount < 10
          puts "That's less than a min bet. Please enter at least 10"
          redo
        elsif bet_amount >= @other_player.chips
          puts "You cannot bet more than your own chip count. Please try again. (If you want to go all-in, type 'a')"
          redo
        else
          pot_before = @pot
          @op_bet = bet_amount
          @pot += @op_bet
          @other_player.chips -= @op_bet
          bet_loop = false
          puts_cards("button")
          puts "#{@button_player.name}, #{@other_player.name} has bet #{@op_bet} into a #{pot_before} chip pot. The pot is now #{@pot}. #{@op_bet - @bp_bet} chips to call. What do you want to do? ( f, c, r, or a)"
          action = gets.chomp
          action, val = use_wit(action)
          determine_action(@button_player, action, val, "call/raise") 
        end
      end
    elsif player == @button_player
      bet_loop = true
      first_loop = true
      while bet_loop == true
        bet_amount = 0
        if val != -1 and first_loop
          first_loop = false
          bet_amount = val
        else
          puts "#{@other_player.name}, the pot is #{@pot}. How much would you like to bet?"
          bet_amount = gets.chomp
          bet_amount = use_wit_num(bet_amount)
        end
        if bet_amount > @other_player.chips
          @pot += @other_player.chips
          @button_player.chips -= @other_player.chips
          @bp_bet = @other_player.chips
          bet_loop = false
          puts_cards("other")
          puts "#{@other_player.name}, #{@button_player.name} has put you all-in. Would you like to call?"
          answer = gets.chomp
          if answer == "y"
            call(@other_player)
            bet_loop = false
          elsif answer == "n"
            fold(@other_player)
            bet_loop = false
          end
        elsif bet_amount < 10
          puts "That's less than a min bet. Please enter at least 10"
          redo
        elsif bet_amount >= @button_player.chips
          puts "You cannot bet more than your own chip count. Please try again. (If you want to go all-in, type 'a')"
          redo
        else
          pot_before = @pot
          @bp_bet = bet_amount
          @pot += @bp_bet
          @button_player.chips -= @bp_bet
          bet_loop = false
          puts_cards("other")
          puts "#{@other_player.name}, #{@button_player.name} has bet #{@bp_bet} into a #{pot_before} chip pot. The pot is now #{@pot}. #{@bp_bet - @op_bet} chips to call. What do you want to do? (f, c, r, or a)"
          action = gets.chomp
          action, val = use_wit(action)
          determine_action(@other_player, action, val, "call/raise")
        end
      end
    end
  end
      
  def raze(player, val)
    if player == @other_player
      raze_loop = true
      first_loop = true
      while raze_loop == true
        raise_amount = 0
        if val != -1 and first_loop
          first_loop = false
          raise_amount = val
        else
          puts "You want to raise the current bet of #{@bp_bet}. How much do you want to raise your bet to?"
          raise_amount = gets.chomp
          raise_amount = use_wit_num(raise_amount)
        end
        if raise_amount > @button_player.chips + @bp_bet
          @pot += (@button_player.chips + (@bp_bet - @op_bet))
          @other_player.chips -= @button_player.chips + (@bp_bet - @op_bet)
          @op_bet = @button_player.chips + @bp_bet
          raze_loop = false
          puts_cards("button")
          puts "#{@button_player.name}, #{@other_player.name} has raised you all-in. Do you wish to call? Type y or n"
          answer = gets.chomp
          if answer == "y"
            call(@button_player)
            raze_loop = false
          elsif answer == "n"
            fold(@button_player)
            raze_loop = false
          end
        elsif raise_amount < 20
          puts "That's less than a min raise. Please enter at least 20"
          redo
        elsif raise_amount >= @other_player.chips
          puts "You cannot raise beyond your own chip count. Please try again. (If you want to go all-in, type 'a')"
          redo
        elsif raise_amount < @bp_bet
          puts "That's not a raise. It's #{@bp_bet - @op_bet} chips to call. Try again."
          redo
        else
          @pot += raise_amount - @op_bet
          @other_player.chips -= (raise_amount - @op_bet)
          @op_bet = raise_amount
          raze_loop = false
          puts_cards("button")
          puts "#{@button_player.name}, #{@other_player.name} has raised the bet to #{@op_bet}. The pot is now #{@pot}. #{@op_bet - @bp_bet} chips to call. What do you want to do? ( f, c, r, or a)"
          action = gets.chomp
          action, val = use_wit(action)
          determine_action(@button_player, action, val, "call/raise") 
        end
      end

    elsif player == @button_player
      raze_loop = true
      first_loop = true
      while raze_loop == true
        raise_amount = 0
        if val != -1 and first_loop
          first_loop = false
          raise_amount = val
        else
          puts "You want to raise the current bet of #{@bp_bet}. How much do you want to raise your bet to?"
          raise_amount = gets.chomp
          raise_amount = use_wit_num(raise_amount)
        end
        if raise_amount > @other_player.chips + @op_bet
          @pot += (@other_player.chips + (@op_bet - @bp_bet))
          @button_player.chips -= @other_player.chips + (@op_bet - @bp_bet)
          @bp_bet = @other_player.chips + @op_bet
          raze_loop = false
          puts_cards("other")
          puts "#{@other_player.name}, #{@button_player.name} has raised you all-in. Do you wish to call? Type y or n"
          answer = gets.chomp
          if answer == "y"
            call(@other_player)
            raze_loop = false
          elsif answer == "n"
            fold(@other_player)
            raze_loop = false
          end
        elsif raise_amount < 20
          puts "That's less than a min raise. Please enter at least 20"
          redo
        elsif raise_amount >= @button_player.chips
          puts "You cannot raise beyond your own chip count. Please try again. (If you want to go all-in, type 'a')"
          redo
        elsif raise_amount < @op_bet
          puts "That's not a raise. It's #{@op_bet - @bp_bet} chips to call. Try again."
          redo
        else
          @pot += raise_amount - @bp_bet
          @button_player.chips -= (raise_amount - @bp_bet)
          @bp_bet = raise_amount
          raze_loop = false
          puts_cards("other")
          puts "#{@other_player.name}, #{@button_player.name} has raised the bet to #{@bp_bet}. The pot is now #{@pot}. #{@bp_bet - @op_bet} chips to call. What do you want to do? (f, c, r, or a)"
          action = gets.chomp
          action, val = use_wit(action)
          determine_action(@other_player, action, val, "call/raise") 
        end
      end
    end
  end

  def all_in(player)
    if player == @other_player
      if @button_player.chips + @bp_bet <= @other_player.chips + @op_bet
        other_player_before = @other_player.chips
        @pot += (@button_player.chips + @bp_bet - @op_bet)
        @other_player.chips -= (@button_player.chips + @bp_bet - @op_bet)
        @op_bet = @button_player.chips + (@bp_bet - @op_bet)
        puts_cards("button")
        puts "#{@button_player.name}, #{@other_player.name} went all-in with their #{other_player_before} remaining chips.  You have #{@button_player.chips} left. Calling will put you all in. Do you wish to call? Type y or n"
        answer = gets.chomp
        if answer == "y"
          call(@button_player)
        elsif answer == "n"
          fold(@button_player)
        end
      else
        @pot += @other_player.chips
        @op_bet = @other_player.chips + @op_bet
        puts_cards("button")
        puts "#{@button_player.name}, #{@other_player.name} went all-in with their #{@other_player.chips} remaining chips. #{visual(@button_player.pocket)} You have #{@button_player.chips} left. Do you wish to call? Type y or n"
        @other_player.chips = 0
        answer = gets.chomp
        if answer == "y"
          call(@button_player)
        elsif answer == "n"
          fold(@button_player)
        end        
      end
    elsif player == @button_player
      if @other_player.chips + @op_bet <= @button_player.chips + @bp_bet
        button_player_before = @button_player.chips
        @pot += (@other_player.chips + @op_bet - @bp_bet)
        @button_player.chips -= (@other_player.chips + @op_bet - @bp_bet)
        @bp_bet = (@other_player.chips + @op_bet - @bp_bet)
        puts_cards("other")
        puts "#{@other_player.name}, #{@button_player.name} went all-in with their #{@bp_bet} remaining chips. You have #{@other_player.chips} left. Calling will put you all in. Do you wish to call? Type y or n"
        answer = gets.chomp
        if answer == "y"
          call(@other_player)
        elsif answer == "n"
          fold(@other_player)
        end
      else
        @pot += @button_player.chips
        @bp_bet = @button_player.chips + @bp_bet
        @button_player.chips = 0
        puts_cards("other")
        puts "#{@other_player.name}, #{@button_player.name} went all-in with their #{@bp_bet} remaining chips. #{visual(@other_player.pocket)} You have #{@other_player.chips} left. Do you wish to call? Type y or n"
        answer = gets.chomp
        if answer == "y"
          call(@other_player)
        elsif answer == "n"
          fold(@other_player)
        end
      end
    end
  end
end

Game.new