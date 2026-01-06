# 4 3
# 515.99 350.79 731.25
# 299.99 515.88 766.10
# 566.25 271.99 444.89
# 865.99 918.55 799.99


def bijuterii(n, m, mat):
    poz = []
    total = 0
    prev = -1
    loc = 0
    for j in range(len(mat[n - 1])):
        if prev < mat[n - 1][j]:
            prev = mat[n - 1][j]
            loc = j
    if prev == -1:
        return "nu se poate"
    total += prev
    poz.append((n, loc + 1))

    for i in range(n - 2, -1, -1):
        maxim = -1
        loc = 0
        for j in range(len(mat[i])):
            if maxim < mat[i][j] and mat[i][j] < prev:
                maxim = mat[i][j]
                loc = j
        if maxim == -1:
            return "nu se poate"
        poz.append((i + 1, loc + 1))
        total += maxim
        prev = maxim

    poz.reverse()
    return total, poz


def main():

    with open("input.txt", "r") as f:
        n, m = map(int, f.readline().split())
        mat = [list(map(float, f.readline().split())) for _ in range(n)]
        print(bijuterii(n, m, mat))



if __name__ == "__main__":
    main()