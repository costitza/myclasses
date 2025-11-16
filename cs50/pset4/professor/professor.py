import random


def main():
    level = get_level()
    score = 0
    for _ in range(10):
        x = generate_integer(level)
        y = generate_integer(level)
        cnt = 0
        guessed = 0
        while cnt < 3:
            try:
                answer = int(input(print_question(x, y)))
                if answer == x + y:
                    guessed = 1
                    break
                print("EEE")
                cnt += 1
            except ValueError:
                cnt += 1
        if not guessed:
            print(f"{x} + {y} = {x + y}")
        else:
            score += 1
    print(f"Score: {score}")

def print_question(x, y):
    return f"{x} + {y} = "

def get_level():
    level = 0
    while True:
        try:
            level = int(input("Level: "))
            if 0 < level < 4:
                return level
            raise ValueError
        except ValueError:
            pass


def generate_integer(level):
    match level:
        case 1:
            return random.randint(0, 10)
        case 2:
            return random.randint(10, 99)
        case 3:
            return random.randint(100, 999)
        case _:
            raise ValueError

if __name__ == "__main__":
    main()