
def media(*lst):
    result = sum(lst) / len(lst)
    return result

def main():
    print(media(2, 4, 6))  # Output: 4.0
    print(media(1, 3, 5, 7, 9))  # Output: 5.0


if __name__ == "__main__":
    main()