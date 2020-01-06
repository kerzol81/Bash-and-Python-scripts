import os
import time
import logging
import datetime


class Logger:
    logging.basicConfig(filename=datetime.datetime.today().strftime("%Y_%m_%d.log"), 
                        format='%(asctime)s %(message)s', 
                        datefmt='%Y-%m-%d %I:%M:%S',  
                        level=logging.INFO)
    @staticmethod
    def log2file(message):
        logging.info(message)


class FolderCleaner:
    _path = ''
    _days = 0
    _files = []
    _directories = []

    def __init__(self, path, days):
        """
        :param path: folder full path
        :param days: represents the days to keep in the folder
        """
        if not os.path.exists(path):
            raise TypeError("folder does not exist")
        self.path = path
        if days < 0 or isinstance(days, bool) or not isinstance(days, int):
            raise ValueError("days must be positive integer")
        self.days = days
        self.fill()

    def fill(self):
        """
        fills up _files and _folders arrays that are older than days
        in order to delete them
        """
        seconds_since_epoch = time.time()
        days_in_seconds = self.days * 24 * 60 * 60
        seconds_span = seconds_since_epoch - days_in_seconds
        for root, dirs, files in os.walk(self.path):
            for file in files:
                stat = os.stat(os.path.join(root, file))
                if stat.st_mtime <= seconds_span:
                    self._files.append(os.path.join(root, file))
            for directory in dirs:
                stat = os.stat(os.path.join(root, directory))
                if stat.st_mtime <= seconds_span:
                    self._directories.append(os.path.join(root, directory))

    def delete_files(self):
        if len(self._files) is 0:
            Logger.log2file('there are no files older than {} days'.format(self.days))
            return 0
        for file in self._files:
            Logger.log2file('{} file deleted'.format(file))
            os.remove(file)

    def delete_folders(self):
        if len(self._directories) is 0:
            Logger.log2file('there are no folders older than {} days'.format(self.days))
            return 0
        for directory in self._directories:
            Logger.log2file('{} folder deleted'.format(directory))
            os.rmdir(directory)
