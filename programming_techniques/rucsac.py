

def main():
    st = input()

    st = st.split()
    n, gmax = [int(elem) for elem in st]

    obs = []
    for i in range(n):
        line = input()

        g, v = [int(elem) for elem in line.split()]

        obs.append([g, v])

    obs.sort(key=lambda x: x[1] / x[0], reverse=True)

    print(obs)

    w = 0
    suma = 0
    cnt = 0

    while w < gmax and cnt < n:
        if w + obs[cnt][0] <= gmax:
            w += obs[cnt][0]
            suma += obs[cnt][1]
        else:
            ramas = gmax - w
            w = gmax

            val = ramas * (obs[cnt][1] / obs[cnt][0])

            suma += val
        cnt += 1
    
    print(suma)


if __name__ == "__main__":
    main()