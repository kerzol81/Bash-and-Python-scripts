"""
http://knightlab.northwestern.edu/2014/06/05/five-mini-programming-projects-for-the-python-beginner/
"""
import random

randomnumber = random.randrange(1, 101)
print("I've though a number between 1 and 100!" + str(randomnumber))

while True:
    try:
        userguess = int(input("Guess!"))

        if not 100 > userguess > 0:
            print("It's in between 0 and 100!")

    except ValueError:
        print("Enter an integer")
        continue

    if userguess == randomnumber:
        print("Congratulations!")
        break

    if userguess < randomnumber:
        print("Larger")

    if userguess > randomnumber:
        print("Smaller")
