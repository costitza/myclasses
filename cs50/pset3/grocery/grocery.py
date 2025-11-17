
groceries = {}

def print_items():
    new_groceries = {key: value for key, value in sorted(groceries.items())}
    for item in new_groceries:
        print(new_groceries[item], item)

def main():

    while True:
        try:
            item = input().strip().upper()
            if item not in groceries:
                groceries[item] = 1
            else:
                groceries[item] += 1
        except EOFError:
            print_items()
            break


if __name__ == "__main__":
    main()