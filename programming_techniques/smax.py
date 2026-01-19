
def citire():
    with open("smax.in", "r") as f:
        for line in f:
            for token in line.split():
                if token:
                    yield int(token)


def main():
    
    arr = []

    iterator = citire()

    n = next(iterator)

    arr = [next(iterator) for _ in range(n)]

    dp = [0] * n

    dp[0] = arr[0]

    if n == 1:
        return str(dp[0])
    
    dp[1] = max(arr[0], arr[1])

    for i in range(2, n):
        dp[i] = max(dp[i - 1], arr[i] + dp[i - 2])


    with open("smax.out", "w") as g:

        g.write(str(dp[n - 1]))



if __name__ == "__main__":
    main()