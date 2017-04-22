import os

folder = "Scott.Ross_Goldberg.Variations"


for i in os.listdir(folder):
    filename, extension = (os.path.splitext(i))
    filenumber = (filename.split('.')[0].zfill(2))
    filename = (filename.split('. ')[1])
    new_filename =('{}.{}{}'.format(filenumber, filename, extension))
    os.rename(i, new_filename)
