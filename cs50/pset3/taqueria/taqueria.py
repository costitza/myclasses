
from zmq import PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_MESSAGE


menu = {
    "baja taco": 4.25,
    "burrito": 7.50,
    "bowl": 8.50,
    "nachos": 11.00,
    "quesadilla": 8.50,
    "super burrito": 8.50,
    "super quesadilla": 9.50,
    "taco": 3.00,
    "tortilla salad": 8.00
}

total = float(0)

def main():
    global total
    while True:
        try:
            str = input("Item: ").strip().lower()
            total += menu[str]
            print(f"Total: ${total:.2f}")
        except KeyError:
            pass
        except EOFError:
            print()
            break


if __name__ == "__main__":
    main()
