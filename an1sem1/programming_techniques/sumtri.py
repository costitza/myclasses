

def is_in(x, n):
    return 0 <= x < n


def parcurgere_dp(dp, mat, n):
    dp[0][0] = mat[0][0]
    
    for i in range(1, n):
        for ind in range(i + 1):
            if is_in(ind - 1, n) and ind != i:
                if dp[i - 1][ind - 1] > dp[i - 1][ind]:
                    dp[i][ind] = dp[i - 1][ind - 1] + mat[i][ind]
                else:
                    dp[i][ind] = dp[i - 1][ind] + mat[i][ind]
            elif is_in(ind - 1, n):
                dp[i][ind] = dp[i - 1][ind - 1] + mat[i][ind]
            else:
                dp[i][ind] = dp[i - 1][ind] + mat[i][ind]
    
    return max(dp[-1])



def main():
    dp = []

    with open("input.txt", "r") as f:
        lines = f.readlines()

        n = int(lines[0].strip())
        mat = []
        for line in lines[1:]:
            lst = list(map(int, line.split()))

            mat.append(lst)
            dp.append([0] * len(lst))

    res = parcurgere_dp(dp, mat, n)

    with open("sumtri.out", "w") as g:
        g.write(str(res))



if __name__ == "__main__":
    main()