import cv2
import pytesseract

"""
How to recognise date&time from a security camera's OnScreenDisplay
In this case the OSD was burnt into the bottom-right corner
"""

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
    osdheight = 30
    osdwidth = 400
    imgHeight = img.shape[0]
    imgWidth = img.shape[1]

    osd = img[imgHeight-osdheight:imgHeight, osdwidth:imgWidth]
    #cv2.imshow('test', osd)
    #cv2.waitKey(2000)
    cv2.imwrite('osd.jpg', osd)

def getDate(osd):
    img = cv2.imread(osd, 0)
    ret, image = cv2.threshold(img, 127, 255, cv2.THRESH_BINARY)
    #cv2.imshow('test', image)
    #cv2.waitKey(0)
    config = '--psm 10 --oem 1 -c tessedit_char_whitelist=-:0123456789'
    text = pytesseract.image_to_string(image, config=config)
    #print(text)
    return str(text)
