
from os import write


input_file = "matrice.in"
output_file = "matrice.out"
mat = []

def calculate_max(row):
    return max(row)

def write_mat(matrix):
    with open(output_file, "w") as out:    
        for row in matrix:
            out.write(" ".join(str(elem) for elem in row))
            out.write("\n")

def main():
    with open(input_file, "r") as file:
        for line in file:
            row = list(map(int, line.split()))
            mat.append(row)
    
    updated_mat = []
    for row in mat:
        to_delete = len(row) - row[::-1].index(calculate_max(row)) - 1
        lst = []
        for i in range(0, to_delete):
            lst.append(row[i])
        for i in range(to_delete + 1, len(row)):
            lst.append(row[i])
        updated_mat.append(lst)
    
    write_mat(updated_mat)
    




if __name__ == "__main__":
    main()