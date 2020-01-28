import os
import logging
import datetime
import shutil


class Logger:
    logging.basicConfig(filename=datetime.datetime.today().strftime("%Y_%m_%d.log"),
                        format='%(asctime)s %(message)s',
                        datefmt='%Y-%m-%d %H:%M:%S',
                        level=logging.INFO)

    @staticmethod
    def log2file(message):
        logging.info(message)


class FileBackup:
    _source = ''
    _destination = ''

    def __init__(self, filename, source, destination):
        if not os.path.exists(os.path.join(source, filename)):
            message = "{} file does not exist in source folder".format(filename)
            Logger.log2file(message)
            raise TypeError(message)
        if not os.path.exists(source):
            message = "{} does not exist".format(source)
            Logger.log2file(message)
            raise TypeError(message)
        if not os.path.exists(destination):
            message = "{} does not exist".format(destination)
            Logger.log2file(message)
            raise TypeError(message)

        self._source = os.path.join(source, filename)     
        self._destination = os.path.join(destination, self.new_filename(filename))
        self.copy()
    
    def new_filename(self, filename):
        return "{}_{}.{}".format(filename.split('.')[0], datetime.datetime.today().strftime("%Y_%m_%d"), filename.split('.')[1])
       
    def copy(self):
        if os.path.exists(self._destination):
            os.remove(self._destination)
        shutil.copy(self._source, self._destination)
    


#
try:
    a = FileBackup('Ny2020.xlsm', 'D:\Backup', 'X:\Backup\')

except Exception as ex:
    print(ex)
