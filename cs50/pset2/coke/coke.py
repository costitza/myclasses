coins = [5, 10, 25]

def main():
    amount_due = 50
    change = 0
    while amount_due > 0:
        print(f"Amount Due: {amount_due}")
        coin = int(input("Insert Coin: "))
        if coin in coins:
            amount_due -= coin

    change = abs(amount_due)
    print(f"Change Owed: {change}")


if __name__ == "__main__":
    main()