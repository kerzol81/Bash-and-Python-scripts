import cv2
import pytesseract
from PIL import Image, ImageFilter, ImageEnhance


def getFirstFrame(videofile):
    vid = cv2.VideoCapture(videofile)
    success, image = vid.read()
    if success:
        cv2.imwrite("first_frame.jpg", image)
        return True
    else:
        return False


def getOSD(frame):
    img = cv2.imread(frame, 0)
    osdheight = 25
    osdwidth = 290
    imgHeight = img.shape[0]
    imgWidth = img.shape[1]

    osd = img[imgHeight-osdheight:imgHeight, osdwidth:imgWidth]
    #cv2.imshow('test', osd)
    #cv2.waitKey(2000)
    cv2.imwrite('first_frame_osd.jpg', osd)

def getDate(osd):
    img = Image.open(osd)
    text = pytesseract.image_to_string(img, config='--psm 10 --oem 1 -c tessedit_char_whitelist=-:0123456789')
    #text = pytesseract.image_to_string(img, config='digits')
    print(text)

def enhanceOSD(osd):
    pass
