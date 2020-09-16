
import RPi.GPIO as GPIO
from .simple import SimpleMFRC522

reader = SimpleMFRC522()

print('Looking for cards')
print('Press ctrl+c to stop.')

try:
	id,text=reader.read()
	print(id)
	print(text)
finally:
	GPIO.cleanup()


