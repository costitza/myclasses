from queue import Queue

def verif(i, j, n):
    return 0 <= i and i < n and 0 <= j and j < n

def cal(n, mat, i, j):
    di = [1, 2, 2, 1]
    dj = [-2, -1, 1, 2]
    dp = [[0 for _ in range(n)] for _ in range(n)]
    parinti = [[None for _ in range(n)] for _ in range(n)]
    drum = []

    q = Queue()
    q.put((i, j))
    while not q.empty():
        ic, jc = q.get()
        for index in range(4):
            inou = ic + di[index]
            jnou = jc + dj[index]
            if verif(inou, jnou, n):
                q.put((inou, jnou))

                if dp[inou][jnou] < dp[ic][jc] + mat[inou][jnou]:
                    dp[inou][jnou] = dp[ic][jc] + mat[inou][jnou]
                    parinti[inou][jnou] = (ic, jc)
    
    maxim = -1
    pos_finala = None
    for j in range(n):
        if dp[n - 1][j] > maxim:
            maxim = dp[n - 1][j]
            pos_finala = (n - 1, j)

    current = pos_finala
    while current is not None:
        drum.append((current[0] + 1, current[1] + 1))
        current = parinti[current[0]][current[1]]
    
    return maxim, drum[::-1]



def main():

    with open("input.txt", "r") as f:
        n = int(f.readline().strip())
        mat = [list(map(int, f.readline().split())) for _ in range(n)]
        starti, startj = map(int, f.readline().split())
        print(cal(n, mat, starti - 1, startj - 1))



if __name__ == "__main__":
    main()