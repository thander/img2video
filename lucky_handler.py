import time
import requests
import runpod
from runpod.serverless.utils.rp_validator import validate
from runpod.serverless.modules.rp_logger import RunPodLogger
from requests.adapters import HTTPAdapter, Retry
import io
import PIL
from PIL import Image
import base64

TIMEOUT = 600

session = requests.Session()
retries = Retry(total=10, backoff_factor=0.1, status_forcelist=[502, 503, 504])
session.mount('http://', HTTPAdapter(max_retries=retries))
session.headers.update({"Content-Type": "application/json", 'Accept': 'application/json'})
logger = RunPodLogger()

# ---------------------------------------------------------------------------- #
#                                RunPod Handler                                #
# ---------------------------------------------------------------------------- #
def handler(event):
	image_base64 = event["input"]["image"]
	options = event["input"]["options"]
	print(image_base64)


if __name__ == "__main__":
    logger.log('API is ready', 'INFO')
    logger.log('Starting RunPod Serverless...', 'INFO')
    runpod.serverless.start(
      {
        'handler': handler
      }
    )