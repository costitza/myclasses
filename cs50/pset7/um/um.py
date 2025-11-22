import re
import sys


def main():
    print(count(input("Text: ")))


def count(s):
    s = s.lower()
    s = re.sub(r"[;,.!?]", " ", s)
    words = s.split()
    return sum(1 for word in words if word == "um")


if __name__ == "__main__":
    main()