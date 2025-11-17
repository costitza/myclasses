

def convert(x, y):
    return ((x / y) * 100)

def get_numbers(prompt):
    while True:
        try:
            numbers = input(prompt).split("/")
            x = int(numbers[0])
            y = int(numbers[1])
            return (x, y)
        except ValueError:
            pass
    

def verify_numbers(x, y):
    if x > y or y == 0:
        return False
    if x < 0 or y < 0:
        return False
    return True

def main():
    while True:
        x, y = get_numbers("Fraction: ")
        if verify_numbers(x, y):
            break
    result = round(convert(x, y))
    if result <= 1:
        print("E")
    elif result >= 99:
        print("F")
    else:
        print(f"{round(convert(x, y))}%")



if __name__ == "__main__":
    main()