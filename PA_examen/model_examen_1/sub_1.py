
def medie_cif(x):
    x = str(x)
    return sum([int(elem) for elem in x]) / sum([1 for elem in x])

def numere(*args):
    dict = {}

    for element in args:
        medie = str(medie_cif(element))

        if dict.get(medie) is None:
            dict[medie] = [element]
        else:
            dict[medie].append(element)
    return dict

# 82375, 201, 51, 73, 3456, 2855, 1021, 90, 153

def main():
    print(numere(82375, 201, 51, 73, 3456, 2855, 1021, 90, 153))


if __name__ == "__main__":
    main()