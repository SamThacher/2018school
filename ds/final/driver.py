import subprocess
import os
from time import sleep
import io
import sys

new = ""
chat = subprocess.Popen(['python3', 'hangmanstart.py'], stdout = subprocess.PIPE)
hang = subprocess.Popen(['python3', 'Hangman.py'])

while True:
	line = chat.stdout.readline()
	if('Loading hangmantest.xml' not in line.decode('utf-8')):
		subprocess.Popen(['echo',line.decode('utf-8')])

# 	read, write = os.pipe() 
	# os.write(write, b"\n")
# stdout, stderr = chat.communicate()
# print(stdout)
# print("aaa")


# while 1==1:
# 	i = 0
	# print(1)
# 	stdout, stderr = chat.communicate()
# 	if(stdout.decode('utf-8').contains("Enter your message")):
# 		print('aaa')
# 	else:
# 		print('\n')

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