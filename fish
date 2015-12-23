#!/usr/bin/env python
# -*- coding: utf-8 -*-

def fishes():
    print '[1]  - Csuka - Esox Lucius'
    print '[2]  - Balin - Aspius Aspius'
    print '[3]  - Sügér - Perca'
    print '[4]  - Fogassüllő - Sander Lucioperca'
    print '[5]  - Kősüllő - Sander Volgensis'
    print '[6]  - Garda - Pelecus Cultratus'
    print '[7]  - Domolyko - Squalius Cephalus'
    print '[8]  - Jászkeszeg - Leuciscus Idus'
    print '[9]  - Szilvaorrú keszeg - Vimba Vimba'
    print '[10] - Paduc - Chondrostoma Nasus'
    print '[11] - Márna - Barbus Barbus'
    print '[12] - Ponty - Cyprinus carpio'
    print '[13] - Compó - Tinca Tinca'
    print '[14] - Harcsa - Silurus Glanis'
    print '[15] - Sebes pisztráng - Salmo Trutta'
    print '[16] - Menyhal - Lota Lota'

def prohibition():
    s = 'Prohibition period: '

    fish = raw_input('Choose fish by number: \n>')
    fish = int(fish)

    if fish is 1:
        print s, '02.01 - 03.31'

    elif fish in [2, 3, 4]:
        print s, '03.01 - 04.30'

    elif fish is 5:
        print s, '03.01 - 06.30'

    elif fish in [6, 7, 8, 9, 10, 11]:
        print s, '04.15 - 05.31'

    elif fish is 12:
        print s, '05.02 - 05.31'

    elif fish in [13, 14]:
        print s, '05.02 - 06.15'

    elif fish is 15:
        print s, '10.01 - 03.31'

    elif fish is 16:
        print s, '---'
        
    else:
        print '\n[-]invalid input'

    raw_input("\n[-]Press Enter for a new search, Ctrl - C for exit\n")

def main():
    while True:
        fishes()
        prohibition()

main()
