#Libraries
import RPi.GPIO as GPIO
import time
from azure.iot.device import IoTHubDeviceClient, Message

CONNECTION_STRING = "<YOUR CONNECTION STRING>"
MSG_TXT = '{{"remaining_space": {remaining_space}}}'

bin_Height = 45

def iothub_client_init():
    # Create an IoT Hub client
    client = IoTHubDeviceClient.create_from_connection_string(CONNECTION_STRING)
    return client

#GPIO Mode (BOARD / BCM)
GPIO.setmode(GPIO.BCM)

#set GPIO Pins
GPIO_TRIGGER = 18
GPIO_ECHO = 24

#set GPIO direction (IN / OUT)
GPIO.setup(GPIO_TRIGGER, GPIO.OUT)
GPIO.setup(GPIO_ECHO, GPIO.IN)

def leftoutSpace():
    # set Trigger to HIGH
    GPIO.output(GPIO_TRIGGER, True)

    # set Trigger after 0.01ms to LOW
    time.sleep(0.00001)
    GPIO.output(GPIO_TRIGGER, False)

    StartTime = time.time()
    StopTime = time.time()

    # save StartTime
    while GPIO.input(GPIO_ECHO) == 0:
        StartTime = time.time()

    # save time of arrival
    while GPIO.input(GPIO_ECHO) == 1:
        StopTime = time.time()

    # time difference between start and arrival
    TimeElapsed = StopTime - StartTime
    # multiply with the sonic speed (34300 cm/s)
    # and divide by 2, because there and back
    distance = (TimeElapsed * 34300) / 2

    return distance

if __name__ == '__main__':
    try:
        client = iothub_client_init()


        while True:
            remaining_space = leftoutSpace()
            msg_txt_formatted = MSG_TXT.format(remaining_space = remaining_space)
            message = Message(msg_txt_formatted)
            temp_calc = ((bin_Height - remaining_space)/bin_Height) *100
            print(temp_calc)
            if temp_calc >= 80:
              message.custom_properties["isBinFull"] = "true"
            else:
              message.custom_properties["isBinFull"] = "false"

            time.sleep(1)
            # Send the message.
            print( "Sending message: {}".format(message) )
            client.send_message(message)
            print ( "Message successfully sent" )
            #send the remaining space of bin every one hour 
            time.sleep(3600)

        # Reset by pressing CTRL + C
    except KeyboardInterrupt:
        GPIO.cleanup()
