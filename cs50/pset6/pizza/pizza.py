import csv
import sys
import os
import tabulate

def check_args():
    if len(sys.argv) != 2:
        sys.exit("Too many or too few command-line arguments")
    if not sys.argv[1].endswith(".csv"):
        sys.exit("Not a CSV file")
    if os.path.exists(sys.argv[1]) is False:
        sys.exit("File does not exist")

def main():
    check_args()
    with open(sys.argv[1], "r") as file:
        reader = csv.DictReader(file)
        result = tabulate.tabulate(reader, headers = "keys", tablefmt = "grid")
        print(result)



if __name__ == "__main__":
    main()