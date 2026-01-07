

def citire_numere(file):
    mat = []

    with open(file, "r") as f:
        lines = f.readlines()
        
        for line in lines:
            mat.append(list(map(int, line.split())))
    return mat


def prelucrare_lista(mat):
    lmin = 100000

    for index in range(len(mat)):
        minim = min(mat[index])
        mat[index] = [elem for elem in mat[index] if elem != minim]
        print(mat[index])

        if lmin > len(mat[index]):
            lmin = len(mat[index])
    
    new_mat = []
    for lst in mat:
        new_lst = []
        for index in range(lmin):
            new_lst.append(lst[index])
        new_mat.append(new_lst)
    
    return new_mat


def punctd(mat):
    k = int(input("da mi K:"))

    rez = []
    for lst in mat:
        for elem in lst:
            if len(str(elem)) == k:
                rez.append(elem)

    rez = list(set(rez))

    rez.sort(reverse=True)

    with open("cifre.out", "w") as g:
        if len(rez) != 0:
            afis = [str(x) for x in rez]
            g.write(" ".join(afis))
        else:
            g.write("Imposibil")
        


def main():
    mat = citire_numere("numere.in")

    print(mat)
    pm = prelucrare_lista(mat)

    for lst in pm:
        afis = [str(x) for x in lst]
        print(" ".join(afis))

    punctd(mat)

if __name__ == "__main__":
    main()