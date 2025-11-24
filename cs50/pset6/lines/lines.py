import sys
import os

def check_args():
    if len(sys.argv) != 2:
        sys.exit("Too many or too few command-line arguments")
    if not sys.argv[1].endswith(".py"):
        sys.exit("Not a Python file")
    if os.path.exists(sys.argv[1]) is False:
        sys.exit("File does not exist")


def main():
    counter = 0
    check_args()
    with open(sys.argv[1], "r") as file:
        for line in file:
            stripped_line = line.strip()
            if stripped_line and not stripped_line.startswith("#"):
                counter += 1
    print(counter)


if __name__ == "__main__":
    main()