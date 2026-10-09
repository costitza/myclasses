

def premianti(dict, k, *scoruri):

    res = []

    for echipa in dict:
        for nume in dict[echipa]:
            cnt = 0
            pct = []
            for scor in scoruri:
                # print(dict[echipa][nume])

                if scor in dict[echipa][nume]:
                    # print("da")
                    cnt += 1
                    pct.append(scor)
            if cnt >= k:
                medie = sum(elem for elem in dict[echipa][nume] if elem in scoruri) / sum([1 for elem in dict[echipa][nume] if elem in scoruri])
                res.append((echipa, nume, [elem for elem in dict[echipa][nume]], round(medie, 2)))

    return sorted(res, key=lambda x: (-x[3], x[0], x[1]))


def sterge(dict, echipa, nume):
    del dict[echipa][nume]

    

    if len(dict[echipa].keys()) < 2:
        x = ""
        for elem in dict[echipa].keys():
            x = elem
        del dict[echipa]
        return f"Am sters si jucatorul {x} si echipa {echipa}"
    return dict[echipa]



def main():
    dict = {}

    with open("punctaje.in", "r") as f:
        lines = f.readlines()

        echipa = ""
        for line in lines:
            
            if "Echipa " in line:
                echipa = line.removeprefix("Echipa ").strip()
            else:
                nume, pct = line.split(" : ")
                nume.strip()
                pct = pct.split()
                pct = list(map(int, pct))

                if dict.get(echipa) is not None:
                    dict[echipa].update({nume : pct})
                else:
                    dict[echipa] = {nume : pct}
    
    # for echipa in dict.keys():
        # print(echipa, "->", dict[echipa])

    print(premianti(dict, 3, 50, 25, 40, 60, 30, 45))
    
    e = input("Nume de echipa: ")
    j = input("Nume de jucator: ")
    print(sterge(dict, e, j))

    print(dict)


if __name__ == "__main__":
    main()