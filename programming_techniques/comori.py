
def make_dp(dp, mat, n, m):
    
    dp[0] = mat[0][:]

    
    for i in range(1, n):
        for j in range(m):
            pos = [dp[i - 1][j]]

            if j > 0:
                pos.append(dp[i - 1][j - 1])
            if j < m - 1:
                pos.append(dp[i - 1][j + 1])
            
            dp[i][j] = mat[i][j] + max(pos)
    
    return max(dp[-1])


def main():
    
    with open("comori.in", "r") as f:
        lines = f.readlines()
        parts = lines[0].split()

        n, m = int(parts[0]), int(parts[1])
        dp = []
        mat = []
        for line in lines[1:]:
            mat.append(list(map(int, line.split())))
            dp.append([0] * m)

        # print(mat)
    

    res = make_dp(dp, mat, n, m)

    # print(dp)
    with open("comori.out", "w") as g:
        g.write(str(res))



if __name__ == "__main__":
    main()