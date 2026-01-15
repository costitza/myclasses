

def lis(lst):

    n = len(lst)
    dp = [1] * n

    pred = [-1] * n

    for i in range(1, n):
        for j in range(0, i):
            if dp[i] < dp[j] + 1 and lst[i] > lst[j]:
                dp[i] = dp[j] + 1
                pred[i] = j

    maxim = -1
    index = 0
    for i in range(n):
        if dp[i] > maxim:
            maxim = dp[i]
            index = i
    

    res = []
    curr = index
    while curr != -1:
        res.append(lst[curr])
        curr = pred[curr]
    
    return res[::-1]


def main():
    
    t = [10, 22, 9, 33, 21, 50, 41, 60, 80]
    print(lis(t))


if __name__ == "__main__":
    main()