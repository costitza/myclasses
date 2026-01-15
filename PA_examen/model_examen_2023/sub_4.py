

def bkt(solutie, n):
    if len(solutie) == n:

        print(" ".join(list(map(str, solutie))))
        return
    

    for i in range(1, n + 1):
        if i not in solutie:
            bkt(solutie + [i], n)
    
    


def main():
    bkt([], n=5)


if __name__ == "__main__":
    main()