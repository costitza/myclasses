

def main():
    greeting = input("Greeting: ")
    greeting = greeting.lower().strip()
    if greeting[:5] == "hello":
        print("$0")
    elif greeting[0] == "h":
        print("$20")
    else:
        print("$100")


main()