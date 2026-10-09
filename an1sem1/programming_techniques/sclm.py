# Longest increasing subsequence

def lis(n, arr):

    dp = [-1] * n
    dp[0] = 1

    prev = [-1] * n

    for i in range(1, n):
        for j in range(0, i):
            if dp[i] < dp[j] + 1 and arr[i] > arr[j]:
                dp[i] = dp[j] + 1
                prev[i] = j
    
    final_pos = 0
    mx = -1
    for i in range(n):
        if mx < dp[i]:
            mx = dp[i]
            final_pos = i
    
    res = []
    curr = final_pos
    while curr != -1:
        res.append(curr + 1)
        curr = prev[curr]
    
    res.reverse()
    return mx, res


def citire():
    with open("sclm.in", "r") as f:
        for line in f:
            for token in line.split():
                yield int(token)


def main():
    
    iterator = citire()

    n = next(iterator)
    arr = [next(iterator) for _ in range(n)]



    mx, res = lis(n, arr)
    
    with open("sclm.out", "w") as g:
        g.write(str(mx))
        g.write("\n")
        g.write(" ".join(list(map(str, res))))


if __name__ == "__main__":
    main()