import subprocess


chat = subprocess.Popen(['python3', 'hangmanstart.py'], stdout=subprocess.PIPE)
hang = subprocess.Popen(['python3', 'Hangman.py'])
while True:
	i = 0
	# nothing
# stdout, stderr = dummy.communicate()
# stdout_string = stdout.decode('utf-8')
# print(stdout)
# stdout_string = stdout_string.replace("Enter your message >>", "")
# print(stdout_string)
# stdout = stdout_string.encode('utf-8')
# print(stdout)
# hangman = subprocess.Popen(['python3', 'Hangman.py'], stdin=stdout, stderr=subprocess.PIPE)
# hangman.communicate()[0]
# while hangman.poll() is None:
# 	print(hangman.stdout.readline().strip().decode('ascii'))