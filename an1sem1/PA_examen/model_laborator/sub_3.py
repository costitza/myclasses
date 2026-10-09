

def actualizeaza_preturi(dict, magazin, categorie, *preturi):

    dict[magazin][categorie] = preturi

    for cat in dict[magazin]:
        print(cat, *dict[magazin][cat])
    

def main():
    dict = {}

    with open("magazin.in", "r") as f:
        lines = f.readlines()

        for line in lines:
            parts = line.split("#")
            magazin = parts[0].strip()
            produs = parts[1].strip()

            preturi = list(map(float, parts[2].split()))

            if dict.get(magazin) is not None:
                dict[magazin].update({produs : preturi})
            else:
                dict[magazin] = {produs : preturi}

    print(dict)

    actualizeaza_preturi(dict, "Mega Image", "Lactate", 9.0, 12.5, 4.6)

if __name__ == "__main__":
    main()