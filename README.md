# Microsoft-Azure-Smart-Waste-Segregation-Bin-using-Azure-Services

<!-- TABLE OF CONTENTS -->
## Table of Contents
* [About the Project](#about-the-project)
* [Built With](#built-with)
* [Set Up the Azure Backend](#set-up-the-azure-backend)
* [Connecting the sensors with Raspberry Pi](#connecting-the-sensors-with-raspberry-Pi)
* [How to Run Bin Part Using Raspberry Pi](#how-to-run-bin-part-using-raspberry-pi)
* [Run the Flutter App](#run-the-flutter-app)

<!-- ABOUT THE PROJECT -->
## About The Project
Today all the wastes are disposed at street bins and are collectively dumped over a large are of land.​

These wastes are not treated or segregated properly, which causes shortening of land area in the near future.​

Also people don't show up interest in dumping wastes as per classification. ​

India generates approximately 1,33 ,760 tons of MSW per day, of which approximately 91,152 tons is collected and approximately 25 ,884 tons is treated. From that, only 10% - 15% wastes are recycled.

### Solution
A bin is designed such that it takes the input waste from the user and classifies it majorly as plastic/paper/metal and pushes the waste to the respective bin.(Eg: Metal objects are detected and sent to the metal bin).Hence a main bin has three small bins into it.

Each user is issued an RFID card where he/she has to show it to the RFID reader attached to the bin before throwing the waste. The reason behind this is to track the amount of waste(plastic/paper/metal) thrown by each user, so that the recycling cost can be rewarded back to the user. This would encourage the user to throw the waste properly into the bin.

The bin has a Raspberry Pi which is connected to a Metal Sensor(to detect metals), Camera(Azure Custom Vision to detect plastic/paper using AI), RFID reader(to identify the user), Weight Sensor(to calculate the amount of weight in kG).
When a user throws a waste, the waste type(plastic/paper/metal) is detected and its weight is calculated and this data is written to Azure Cosmos DB for the respective user.​

A Cross Mobile App(using Flutter) is made which the user can sign in using his/her RFID code and track the amount of waste thrown by them(data read from Cosmos DB). Also, the user can redeem for points/credits using the App. These points/credits are based on the amount of waste the user has put into the bin for each classification. ​

Each of the three bins(paper/plastic/metal) has an ultrasonic sensor which helps to sense how much the bin has filled. Once 80% of the bin is filled, notifications via email(using Azure Logic Apps) are sent to the Recycling Industries. This ensures that the bin is not overfilled and also the bin is refreshed timely when its needed.
## Built With
* IOT Hub – to get input from Ultrasonic Sensor
* Azure Logic App – to send email Notifications
* Azure Cosmos DB – to track the user data
* Azure Custom Vision – to detect plastic/paper 
* Azure Service Bus – to link IOT hub and Logic App

## Set Up the Azure Backend
### 1) Register Raspberry Pi with Azure IOT Hub
Go through this link to register the raspberry pi [How to register a new device in IOT Hub](https://docs.microsoft.com/en-us/azure/iot-edge/how-to-register-device)
### 2) Training the model using Azure Custom Vision
Create a new Azure Cognitive Service in the Azure Portal and go to the Quick Start(in navigation pane) and click Custom Vision Portal.
This will take you to the Azure Custom Vision Portal.

Download the dataset from the following google drive link as dataset size is big.

## [Dataset](https://drive.google.com/drive/folders/1Hn8UzwQc3IgISwn0rDGLSNIjX7SQbuH8?usp=sharing)

Add the images as per tag and train it in the Custom Vison Potal as mentioned in the below link

[Train a model in Custom Vision](https://docs.microsoft.com/en-us/azure/cognitive-services/custom-vision-service/getting-started-build-a-classifier)

It takes few minutes to train the model. Once the model is trained , go to the performance menu and publish the model.

### 3) Create a Cosmos DB Container 
This has to be setup in order to write and read data.The data(i.e. the type of the waste, weight of the waste) is written into CosmosDB by our Raspberry Pi. Similarly when a user does log in via the Flutter App, the data is fetched from Cosmos DB and it is read. 
* Go to the Azure Portal
* Create a database named 'Bin_Users'
* Create a container name 'users
To get more idea on how to create a container in Cosmos DB refer the link [Quickstart with Azure Cosmos DB](https://docs.microsoft.com/en-us/azure/cosmos-db/create-cosmosdb-resources-portal)
Add a mock data as in the follwing prescribed format
```sh
{
    "id": "123456",
    "userId": "123456",
    "plastic_Numbers": 0,
    "paper_Numbers": 0,
    "metal_Numbers": 0,
    "metal_Weight": 0,
    "plastic_Weight": 0,
    "paper_Weight": 0
}
```
### 4) Create Service Bus and Azure Logic App
This part is essential in order to get automated emails when the bins are **80%** filled. Raspberry pi keeps sending data every hour on how much the bin is filled. Azure Logic App gets triggered when the threshold exceeds **80%**.
Refer the link to setup the azure logic app [IoT remote monitoring and notifications with Azure Logic Apps connecting your IoT hub and mailbox](https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-monitoring-notifications-with-azure-logic-apps)

Change the query in adding the route as follows
```sh
binFullAlert = "true"
```
## Connecting the sensors with Raspberry Pi
### 1) Connect the RFID reader to Raspberry Pi as shown in the circuit diagram below
![](https://pi.lbbcdn.com/wp-content/uploads/2017/10/RFID-Fritz-v2.png)
### 2) Connect the Ultrasonic Sensor to Raspberry Pi as shown in the circuit diagram below
![](http://www.knight-of-pi.org/wp-content/uploads/2015/12/ultrasonic_breadboard_FIXED.jpg)
### 3) Connect the HX711 Weight Sensor to Raspberry Pi as shown in the circuit diagram below
![](https://tutorials-raspberrypi.de/wp-content/uploads/Raspberry-Pi-HX711-Steckplatine-600x342.png)
### 4) Connect the V2 Camera in the Camera port of Raspberry Pi as shown below
![](https://www.allaboutcircuits.com/uploads/articles/raspberry-pi-camera-2.png?v=1470886330073)
### 5) Connect the Metal sensor in place of the LED in Raspberry Pi as shown below 
The positive and negative of the metal sensor should go exact same as the led's positive and negative.
![](https://cdn.shopify.com/s/files/1/0176/3274/files/LEDs-BB400-1LED_bb_grande.png?6398700510979146820)
## How to Run Bin Part Using Raspberry Pi
### Prerequisite
* Clone the Waste_Segregation_Raspberry_Pi folder in Raspberry Pi
* Install the following packages in Raspberry Pi.
* Launch the terminal and install 
```sh
pip install -r requirements.txt
```
### Set your AZURE Credentials 
* Open the config.py file and change the following details from your Azure Portal for Cosmos DB.
```sh
settings = {
    'host': os.environ.get('ACCOUNT_HOST', '<YOUR HOST NAME>'),
    'master_key': os.environ.get('ACCOUNT_KEY', 'YOUR ACCOUNT MASTER KEY'),
    'database_id': os.environ.get('COSMOS_DATABASE', '<YOUR DATABASE ID>'),
    'container_id': os.environ.get('COSMOS_CONTAINER', '<YOUR CONTAINER ID>'),
}
```
* Open the detect_waste.py file and change the following details from your Azure Custom Vision Portal.
```sh
ENDPOINT = "<CUSTOM VISION ENDPOINT>"
training_key = "<YOUR TRAINING KEY >"
prediction_key = "<YOUR PREDICTION KEY >"
prediction_resource_id = "<YOUR RESOURCE ID>"
publish_iteration_name = "<YOUR ITERATION NAME>"
project_id="<YOUR PROJECT ID>"
```
* Open the iothubBinFullCheck.py file and change the following details from your Azure IOT HUB Portal.
```sh
CONNECTION_STRING = "<YOUR CONNECTION STRING>"
```

Run the bin.py file to perform the Main Bin's job
```sh
python bin.py
```
Run the iothubBinFullCheck.py file to perform the email notifications Part for bin's capacity
```sh
python iothubBinFullCheck.py
```
Check out the video demo for more clarity

## Run the Flutter App
### Set your AZURE Credentials 
* Open the generate_auth_token.dart and change the following details from your Azure Cosmos DB Portal.
```sh
String masterKey = '<YOUR MASTER KEY(Cosmos DB)>';
String resourceId = '<Your Resoure Id>';
```
* Clone the flutter app directory
* Setup Visiual Studio Code for App Development and run the app.

      
