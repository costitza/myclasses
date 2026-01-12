
from math import sqrt

def citire_matrice(file):

    with open(file, "r") as f:
        lines = f.readlines()

        n = int(sqrt(int(lines[0])))

        lines.remove(lines[0])

        mat = []
        i = 0
        a = []
        for elem in lines:
            if i == n:
                i = 1
                mat.append(a)
                a = [int(elem)]
                continue
            a.append(int(elem))
            i += 1
    mat.append(a)
    return mat


def prelucrare_matrice(mat):

    cnt = 0
    for index in range(len(mat)):
        minus = mat[index][cnt]
        for i in range(len(mat[index])):
            mat[index][i] -= minus
        cnt += 1 
    
    res = mat.copy()
    cnt = 0
    for index in range(len(mat)):
        mat[index] = res[index][:index]
        mat[index].extend(res[index][index + 1:])


def suma_c(x):
    suma = 0
    x = str(x).replace("", " ")
    x = x.split()
    for ch in x:
        suma += int(ch)

    print(suma)
    return suma


def functie_d(k, mat):
    res = []

    for lst in mat:
        for elem in lst:
            
            if suma_c(elem) == k:
                res.append(elem)

    for elem in res:
        while res.count(elem) > 1:
            res.remove(elem)

    with open("numere.out", "w") as g:
        if len(res) == 0:
            g.write("Imposibil!")
            return
        g.write(" ".join(list(map(str, res))))



def main():
    mat = citire_matrice("matrice.in")
    matd = mat.copy()
    print(matd)

    k = int(input("Da mi K:"))
    functie_d(k, matd)

    print(mat)
    prelucrare_matrice(mat)

    for lst in mat:
        print(*lst)



if __name__ == "__main__":
    main()