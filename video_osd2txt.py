import cv2
import pytesseract


def getFirstFrame(videofile):
    vid = cv2.VideoCapture(videofile)
    success, image = vid.read()
    if success:
        cv2.imwrite("first_frame.jpg", image)
        return True
    else:
        return False


def getOSD(frame):
    """ the OSD is on the left at the bottom"""
    img = cv2.imread(frame, 0)
    osdheight = 30
    osdwidth = 400
    imgHeight = img.shape[0]
    imgWidth = img.shape[1]

    osd = img[imgHeight-osdheight:imgHeight, osdwidth:imgWidth]
    cv2.imwrite('osd.jpg', osd)


def getDate(osd):
    img = cv2.imread(osd, 0)
    ret, image = cv2.threshold(img, 127, 255, cv2.THRESH_BINARY)
    config = '--psm 10 --oem 1 -c tessedit_char_whitelist=-:0123456789'
    text = pytesseract.image_to_string(image, config=config)
    return text
