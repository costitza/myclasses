

from unittest import result


def citire():
    mat = []

    with open("matrice.in", "r") as f:
        lines = f.readlines()

        for line in lines:
            lst = list(map(int, line.split()))
            mat.append(lst)

    return mat


def sort(mat):

    result = []
    for lst in mat:
        new_lst = sorted(lst)
        result.append(new_lst)
    
    return result


def sterge(mat, mats):


    for index in range(len(mats)):
        mats[index] = mats[index][:4]

        # print(mats[index])

        mat[index] = [elem for elem in mat[index] if elem in mats[index]]
        mat[index] = mat[index][:4]
        # print(mat[index])

    return mat


def main():
    mat = citire()
    mat_sortata = sort(mat)


    mat = sterge(mat, mat_sortata)

    with open("matrice.out", "w") as g:
        for lst in mat:
            g.write(" ".join(list(map(str, lst))))
            g.write("\n")




if __name__ == "__main__":
    main()