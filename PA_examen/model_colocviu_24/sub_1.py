
def citire_numere():
    with open("numere.in", "r") as f:
        lines = f.readlines()
        mat = []
        for line in lines:
            mat.append(list(map(int, line.split())))
        return mat

def minim_k(mat, k):
    numere_toate = [mat[i][j] for i in range(len(mat)) for j in range(len(mat[i]))]
    numere = list(set(numere_toate))
    
    cerinta = []

    for numar in numere:
        cnt = 0
        for lst in mat:
            if numar in lst:
                cnt += 1
        if cnt >= k:
            cerinta.append(numar)
    return sorted(cerinta, reverse=True)


def insereaza_zerouri(mat, x):
    nm = []
    pt_sters = []

    for i in range(len(mat)):
        for j in range(len(mat[i])):
            nm.append([])
            if mat[i][j] % (x + i) == 0:
                nm[i].append(mat[i][j])
                nm[i].append(0)
            else:
                nm[i].append(mat[i][j])
    
    for i in range(len(nm) - 1):
        if nm[i].count(0) == len(nm[i]) - nm[i].count(0):
            pt_sters.append(nm[i])
    

    nm = [nm[i] for i in range(len(nm)) if nm[i] not in pt_sters]
    return nm



def main():
    m = citire_numere()
    with open("numere.out", "w") as g:
        nm = insereaza_zerouri(m, 2)
        for i in range(len(nm)):
            g.write(" ".join(map(str, nm[i])))
            g.write('\n')
    


if __name__ == "__main__":
    main()