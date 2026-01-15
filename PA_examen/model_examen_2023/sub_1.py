

def prime(x):
    if x < 2 or x > 2 and x % 2 == 0:
        return False

    d = 3
    while d * d <= x:
        if x % d == 0:
            return False
        d += 2
    return True



def divizori(*numere):
    dict = {}

    for num in numere:

        for d in range(1, num):
            if num % d == 0 and prime(d) == True:
                if dict.get(num) is not None:
                    dict[num].append(d)
                else:
                    dict[num] = [d]
    
    return dict




def main():
    

    print(divizori(50, 21))

    litere_10 = [chr(elem + 97) for elem in range(10)]
    print(litere_10)

    litere_10 = [elem for elem in "abcdefghij"]
    print(litere_10)


if __name__ ==  "__main__":
    main()