

def bkt(solutie, k, dif, n):
    if k == 2 * n:
        print("".join(solutie))
        return 
    
    # print(solutie)

    if dif + 1 <= 2 * n - (k + 1):
        solutie[k] = "("
        bkt(solutie, k + 1, dif + 1, n)
    if dif - 1 >= 0:
        solutie[k] = ")"
        bkt(solutie, k + 1, dif - 1, n)



def main():
    n = int(input("n : "))
    n *= 2

    lst = [""] * n

    lst[0] = "("
    bkt(lst, 1, 1, n // 2)



if __name__ == "__main__":
    main()