import os
import shutil
import datetime

sc_folders = [r'/home/zoli/sc1', r'/home/zoli/sc2', r'/home/zoli/sc3 ]


def check(folder='.'):
    """ returns True if the folder exists, the default folder is current directory"""
    if os.path.exists(folder) is False:
        print('[!] {} does not exist, skipping folder.'.format(folder))
        return False
    else:
        return True


def arrange(folder='.'):
    """ moves files into daily folders """
    if check(folder):
        os.chdir(folder)
        if len(os.listdir(folder)) is 0:
            print('[!] {} is empty.'.format(folder))
        else:
            for file in os.listdir(folder):
                if 'wav' in file.lower():
                    day = file.split('_')[0]
                    day = datetime.datetime.strptime(day, '%y%m%d').strftime('%Y-%m-%d')
                    if not os.path.exists(day):
                        os.mkdir(day)
                        shutil.move(file, day)
                    else:
                        shutil.move(file, day)

                print('[*] {} Done.'.format(folder))


def arrange_all_folders(folders):
    for folder in folders:
        arrange(folder)
    print('[*] Done.')


arrange_all_folders(sc_folders)
