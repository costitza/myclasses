
def mediana(l1, l2):
    n = len(l1)
    # print(l1, l2)

    if n == 2:
        return (max(l1[0], l2[0]) + min(l1[1], l2[1])) / 2

    st1, st2 = 0, 0
    dr1, dr2 = n - 1, n - 1

    mid1, mid2 = (dr1 + st1) // 2, (dr2 + st2) // 2

    if n % 2 != 0:
        med1 = l1[mid1]
    else:
        med1 = (l1[mid1] + l1[mid1 + 1]) / 2
    if n % 2 != 0:
        med2 = l2[mid2]
    else:
        med2 = (l2[mid2] + l2[mid2 + 1]) / 2

    # print(med1, med2)


    if med1 == med2:
        return med1

    if n % 2 != 0:
        if med1 < med2:
            # return mediana(l1[st1:mid1+1], l2[mid2:dr2+1])
            return mediana(l1[mid1:dr1+1], l2[st2:mid2+1])
        return mediana(l1[st1:mid1+1], l2[mid2:dr2+1])
    if med1 < med2:
        # return mediana(l1[st1:mid1+1], l2[mid2:dr2+1])
        return mediana(l1[mid1:dr1+1], l2[st2:mid2+2])
    return mediana(l1[st1:mid1+2], l2[mid2:dr2+1])


def main():
    lst1 = [1, 2, 16, 17, 18]
    lst2 = [12, 13, 15, 30, 45]
    # 2 13 15 16 17 18 30 45


    print(mediana(lst1, lst2))


if __name__ == "__main__":
    main()