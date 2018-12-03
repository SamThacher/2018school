import aiml

# Create the kernel and learn AIML files
kernel = aiml.Kernel()
kernel.learn("hangmantest.xml")
# I used this load aiml b to print out the initial command that begins the conversation
# print(kernel.respond("LOAD AIML B"))

# Press CTRL-C to break this loop
while True:
    print(kernel.respond(input("Enter your message >> ")))