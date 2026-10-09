


def adaugare(dict, nume_proba, nume_concurent, lista_nr):

    if dict.get(nume_concurent) is not None:
        if dict[nume_concurent].get(nume_proba) is not None:
            dict[nume_concurent][nume_proba] += lista_nr

            return len(dict[nume_concurent][nume_proba])
    return "Numele probei sau al concurentului nu exista!"


def rezulate(dict, *probe, n):
    rez = []

    for concurent in dict:
        for proba in probe:
            if proba in dict[concurent]:
                if len(dict[concurent][proba]) >= n:
                    luatmin = 0
                    luatmax = 0
                    new_lst = []
                    for elem in dict[concurent][proba]:
                        if elem == max(dict[concurent][proba]):
                            if luatmax == 1:
                                new_lst.append(elem)
                            luatmax = 1
                        elif elem == min(dict[concurent][proba]):
                            if luatmin == 1:
                                new_lst.append(elem)
                            luatmin = 1
                        else:
                            new_lst.append(elem)
                        
                    medie = round(sum(new_lst) / sum([1 for _ in new_lst]), 2)

                    new_lst.sort(reverse=True)
                    rez.append((proba, concurent, medie, new_lst))

    rez.sort(key=lambda x: (x[0], -x[2], x[1]))
    return rez                    



def main():
    dict = {}

    with open("concurs.in", "r") as f:
        lines = f.readlines()

        concurent = lines[0].strip()
        for line in lines[1:]:
            if " " not in line.strip():
                concurent = line.strip()
            else:
                parts = line.split()
                proba = parts[0]
                if proba == "trambulina":
                    rez = list(map(int, parts[1:]))
                else:
                    rez = list(map(float, parts[1:]))
                if dict.get(concurent) is not None:
                    dict[concurent].update({proba : rez})
                else:
                    dict[concurent] = {proba : rez}

    # print(dict)

    rez = rezulate(dict, "trambulina", "greutati", n=5)

    for elem in rez:
        print(elem)

    
    p = input("nume proba: ")
    c = input("nume concurent: ")
    numere = list(map(int, input("lista de rezulatate: ").split()))

    print(str(adaugare(dict, p, c, lista_nr=numere)))




if __name__ == "__main__":
    main()