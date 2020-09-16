from azure.cognitiveservices.vision.customvision.training import CustomVisionTrainingClient
from azure.cognitiveservices.vision.customvision.training.models import ImageFileCreateBatch, ImageFileCreateEntry
from msrest.authentication import ApiKeyCredentials

#testing
from azure.cognitiveservices.vision.customvision.prediction import CustomVisionPredictionClient
from msrest.authentication import ApiKeyCredentials

from picamera import PiCamera
from time import sleep


camera = PiCamera()
ENDPOINT = "<CUSTOM VISION ENDPOINT>"

# Replace with a valid key
training_key = "<YOUR TRAINING KEY >"
prediction_key = "<YOUR PREDICTION KEY >"
prediction_resource_id = "<YOUR RESOURCE ID>"

publish_iteration_name = "<YOUR ITERATION NAME>"

project_id="<YOUR PROJECT ID>"



def detectWaste():
    #capture image
    camera.capture('/home/pi/Desktop/image.jpg')
    # Now there is a trained endpoint that can be used to make a prediction
    prediction_credentials = ApiKeyCredentials(in_headers={"Prediction-key": prediction_key})
    predictor = CustomVisionPredictionClient(ENDPOINT, prediction_credentials)

    with open("image.jpg", "rb") as image_contents:
        results = predictor.classify_image(
            project_id, publish_iteration_name, image_contents.read())

        # Display the results.
        result = ''
        #returning the result for maximum prediction score. Threshold 50%
        for prediction in results.predictions:
            if(prediction.probability * 100 >50):
                result = prediction.tag_name
            print("\t" + prediction.tag_name +
                  ": {0:.2f}%".format(prediction.probability * 100))
        return result
