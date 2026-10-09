persoane = [
    {"nume": "Ana", "varsta": 25, "oras": "Cluj"},
    {"nume": "Mihai", "varsta": 30, "oras": "Cluj"},
]


def filtreaza_persoane(persoane, **criterii):
    result = []
    for person in persoane:
        good = True
        for key, value in criterii.items():
            if person.get(key) != value:
                good = False
                break
        if good:
            result.append(person)
    return result


def main():
    print(filtreaza_persoane(persoane, oras="Cluj"))
    print(filtreaza_persoane(persoane, varsta=30))


if __name__ == "__main__":
    main()