

def top_spiridusi(dict, *nume, nr_minim):
    
    res = []

    for name in nume:
        jc = []
        total = 0
        for jucarie in dict[name]:
            if dict[name][jucarie] >= nr_minim:
                jc.append(jucarie)
                total += dict[name][jucarie]
        
        if len(jc) > 0:
            res.append((name, jc, total))

        
    res.sort(key=lambda x: (-len(x[1]), -x[2], x[0]))
    return res


def adauga_bucati(dict, nume_spiridus, nume_jucarie = "", nr_bucati = 1):

    if nume_jucarie != "":
        if dict[nume_spiridus].get(nume_jucarie) is not None:
            dict[nume_spiridus][nume_jucarie] += nr_bucati
        else:
            dict[nume_spiridus][nume_jucarie] = nr_bucati
    else:
        for jucarie in dict[nume_spiridus]:
            dict[nume_spiridus][jucarie] += nr_bucati
    total = 0
    for jucarie in dict[nume_spiridus]:
        total += dict[nume_spiridus][jucarie]
    return total



def main():

    dict = {}

    with open("spiridusi.in", "r") as f:
        lines = f.readlines()
        for line in lines:

            parts = line.split(" : ")
            print(parts)

            nume = parts[0].strip()
            jucarii = parts[1].split()

            # print(nume, jucarii)

            j = ""
            for part in jucarii[:-1]:
                j += f"{part} "
            j = j.strip()
            nr = int(jucarii[-1])
            # print(nume, j, nr)

            if dict.get(nume) is not None:
                if dict[nume].get(j) is not None:
                    dict[nume][j] += nr
                else:
                    dict[nume].update({j : nr})
            else:
                dict[nume] = {j : nr}

    # print(dict)
    res = top_spiridusi(dict, "Spiridus Harnic", "Spiridus Poznas", "Spiridus Jucaus", nr_minim=2)

    # print(res)

    s = input("s: ")
    j = input("j: ")


    print(adauga_bucati(dict, s, j))




if __name__ == "__main__":
    main()