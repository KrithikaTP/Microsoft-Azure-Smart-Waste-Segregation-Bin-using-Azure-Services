import RPi.GPIO as GPIO
from SimpleMFRC522 import SimpleMFRC522
#from . import SimpleMFRC522.SimpleMFRC522()

reader = SimpleMFRC522()
#reader = SimpleMFRC522.SimpleMFRC522()

try:
	text=raw_input('Enter new Data to write on card:')
	print('Now place thw card to write...')
	reader.write(text)
	print('data written successfully')

finally:
	GPIO.cleanup()

