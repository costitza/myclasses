def main():
    while True:
        try: 
            fraction = input("Fraction: ")
            percentage = convert(fraction)
            print(gauge(percentage))
            break
        except ValueError:
            pass


def convert(fraction):
    try:
        x, y = fraction.split("/")
        x = int(x)
        y = int(y)

        if x < 0 or y < 0:
            raise ValueError

        if y == 0:
            raise ZeroDivisionError

        if x > y:
            raise ValueError

        return int((x / y) * 100)

    except ValueError:
        raise ValueError("Invalid fraction")
    except ZeroDivisionError:
        raise 



def gauge(percentage):
    if percentage <= 1:
        return "E"
    elif percentage >= 99:
        return "F"
    else:
        return f"{percentage}%"
        

if __name__ == "__main__":
    main()
