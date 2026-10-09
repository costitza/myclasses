

def main():
    file = str(input("fisier:"))
    k = int(input("k dorit:"))

    freq = {}

    with open(file, "r") as f:
        lines = f.readlines()

        for line in lines:
            line = line.lower()

            for semn in "?,.()!:;":
                line = line.replace(semn, "")

            lst = line.split()
            for elem in lst:
                if freq.get(elem) is not None:
                    freq[elem] += 1
                else:
                    freq[elem] = 1
    
    result = []

    for cuvant in freq:
        if freq[cuvant] >= k:
            result.append((cuvant, freq[cuvant]))

    result = sorted(result, key=lambda x: (-x[1], -len(x[0]), x[0]))

    for elem in result:
        print(f"{elem[0]} -> {elem[1]}")




if __name__ == "__main__":
    main()