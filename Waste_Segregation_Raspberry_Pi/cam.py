from picamera import PiCamera
from time import sleep


def takePicture():
    camera = PiCamera()
    camera.start_preview()
    sleep(5)
    camera.capture('/home/pi/Desktop/image.jpg')
    camera.stop_preview()
