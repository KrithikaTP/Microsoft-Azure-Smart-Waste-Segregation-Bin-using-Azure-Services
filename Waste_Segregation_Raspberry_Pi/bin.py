
import RPi.GPIO as GPIO
from mfrc522 import SimpleMFRC522
import metal
import weight
import detect_waste
import cosmos
reader = SimpleMFRC522()

#text contains the RFID
while True:
    try:
        id,text=reader.read()
        text = text.rstrip()
        print(text)
        metalCheck = metal.isMetal()
        #checking if the input waste is metal. Else check for plastic/paper
        if(metalCheck == True):
            print("Metal Detected")
            calcweight = weight.calculateWeight(count)
            cosmos.sendDataToCosmosDB(text,'metal',calcweight)
        else:
            #check whether plastic / paper
            waste = detect_waste.detectWaste()
            if("plastic" in waste):
                waste = 'plastic'
            elif("paper" or "cardboard" in waste):
                waste = 'paper'
            print(str(waste)," Detected")
            calcweight = weight.calculateWeight(count)
            cosmos.sendDataToCosmosDB(text,str(waste),calcweight)

    finally:
        GPIO.cleanup()
