
cnt = 0

def bkt(sol, k, n, viz):
    global cnt

    if len(sol) == k:
        print(*sol)
        cnt += 1
        return 
    
    start = sol[-1] if len(sol) != 0 else 1

    for i in range(start, n + 1):
        if viz[i] != 1:
            viz[i] = 1
            bkt(sol + [i], k, n, viz)
            viz[i] = 0
    



def main():
    
    n = int(input("n : "))
    k = int(input("k : "))

    viz = [0] * (n + 1)
    bkt([], k, n, viz)

    print(cnt)



if __name__ == "__main__":
    main()