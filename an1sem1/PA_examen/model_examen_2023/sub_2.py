




def main():
    n = int(input("Care este n:"))

    spectacole = []

    for _ in range(n):
        st = input()
        st = st.split()

        start = int(st[0])
        finish = int(st[1])
        spectacole.append((start, finish))

    spectacole.sort(key=lambda x: x[1])
    res = [spectacole[0]]


    for spec in spectacole[1:]:
        if res[-1][1] > spec[0]:
            continue
        else:
            res.append(spec)
    

    print(res)



if __name__ == "__main__":
    main()