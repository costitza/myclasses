

def citire_matrice(file):
    mat = []

    with open(file, "r") as f:
        lines = f.readlines()

        for line in lines:
            line = line.split()
            mat.append(line)
    
    return mat


def nr_vocale(s, n):
    s = s.replace("", " ")
    s = s.split()

    nr = 0
    for ch in "aeiou":
        nr += s.count(ch)

    if nr >= n:
        return True
    return False



def prelucrare_siruri(L, n):

    for i in range(len(L)):
        cuvant = ""
        for j in range(len(L[i])):
            cuvant += L[i][j][-1]
        L[i].append(cuvant)

    # print(L)

    rs = []
    for i in range(len(L)):
        new = []
        for j in range(len(L[i])):
            if nr_vocale(L[i][j], n) is True:
                new.append(L[i][j])
        rs.append(new)
    
    for i in range(len(L)):
        L[i] = [elem for elem in L[i] if elem in rs[i]]

    # print(L)


def cuvantw(mat, w):

    res = []
    for lst in mat:
        for elem in lst:
            if w in elem and elem not in res:
                res.append(elem)
    
    with open("cuvinte.out", "w") as g:
        if len(res) != 0:
            res.sort()
            g.write(" ".join(res))
        else:
            g.write("Imposibil!")
        


def main():
    mat = citire_matrice("input.txt")

    print(mat)

    w = input("da : ")
    cuvantw(mat, w)

    prelucrare_siruri(mat, 3)

    for lst in mat:
        print(*lst)



if __name__ == "__main__":
    main()