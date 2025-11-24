import random


def get_random_number():
    while True:
        try:
            positive_number = input("Level: ")
            level = int(positive_number)
            if level > 0:
                break
        except ValueError:
            pass
    return random.randint(1, level)

def guess_number(number):
    while True:
        try:
            guess = int(input("Guess: "))
            if guess < 1:
                raise Exception()
            if guess < number:
                print("Too small!")
            elif guess > number:
                print("Too large!")
            else:
                print("Just right!")
                break
        except ValueError:
            pass
        except Exception:
            pass

def main():
    number = get_random_number()
    guess_number(number)


if __name__ == "__main__":
    main()
