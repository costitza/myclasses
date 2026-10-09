

def citire_liste(file):

    with open(file, "r") as f:
        lines = f.readlines()

        n = int(lines[0].strip())

        mat = [[] for _ in range(n)]

        for line in lines[1:]:
            line = line.split()
            nr, index = int(line[0]), int(line[1])

            mat[index].append(nr)
    return mat


def prelucrare_liste(L, x):

    for i in range(len(L)):
        while x in L[i]:
            L[i].remove(x)

    L[:] = [L[i] for i in range(len(L)) if len(L[i]) > 1]


def nr_div(x):

    nr = 0

    for d in range(1, x + 1):
        if x % d == 0:
            nr += 1
    
    return nr


def ultima_cerinta(mat, k):
    rez = []
    

    for lst in mat:
        for elem in lst:

            # print(nr_div(elem))
            if nr_div(elem) == k and elem not in rez:
                rez.append(elem)

    with open("divizori.out", "w") as g:
        if len(rez) > 0:
            rez.sort(reverse=True)
            g.write("\n".join(list(map(str, rez))))
        else:
            g.write("Imposibil")
    



def main():
    

    mat = citire_liste("input.txt")
    print(mat)

    prelucrare_liste(mat, 0)

    for lst in mat:
        print(*lst)

    k = int(input("Da mi k: "))

    ultima_cerinta(mat, k)





if __name__ == "__main__":
    main()