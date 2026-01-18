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
        res.append(arr[curr])
        curr = prev[curr]
    
    res.reverse()
    return res



def main():
    

    res = lis(5, [3, 10, 2, 1, 20])
    print(res)


if __name__ == "__main__":
    main()