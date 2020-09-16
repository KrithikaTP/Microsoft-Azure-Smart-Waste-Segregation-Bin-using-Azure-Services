import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BOARD)
metal_led = 16
GPIO.setwarnings(False)
GPIO.setup(metal_led,GPIO.IN,pull_up_down=GPIO.PUD_UP)
count = 0
def isMetal():
    while True:
        time.sleep(1)
        count = 1
        if(GPIO.input(metal_led)==0):
            #means metal is detected. Hence returns true
            return True
        else:
            #means no metal object is put. so returning false
            if(count > 5):
                return False
