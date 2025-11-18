import csv
import sys
import os

def check_args():
    if len(sys.argv) != 3:
        sys.exit("Too many or too few command-line arguments")
    if not sys.argv[1].endswith(".csv") or not sys.argv[2].endswith(".csv"):
        sys.exit("Not a CSV file")
    if os.path.exists(sys.argv[1]) is False:
        sys.exit("File does not exist")



def main():
    check_args()
    input_file = sys.argv[1]
    output_file = sys.argv[2]

    with open(input_file, "r") as f:
        contents = csv.DictReader(f)
    
        result = []
        for row in contents:
            last_name, first_name = row["name"].split(", ")
            lst_elem = {
                "last" : last_name,
                "first" : first_name,
                "house" : row["house"] 
            } 
            result.append(lst_elem)

    with open(output_file, "w") as file:
        writer = csv.DictWriter(file, fieldnames = ["first", "last", "house"])
        writer.writeheader()
        for elem in result:
            writer.writerow(elem)



if __name__ == "__main__":
    main()

