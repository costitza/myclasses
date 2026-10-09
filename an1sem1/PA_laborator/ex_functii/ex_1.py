
def salut_persoana(nume, titlu="Dna"):
    return f"Salut, {titlu} {nume}!"


def main():
    print(salut_persoana("Popescu", "Dl"))
    print(salut_persoana("Ionescu"))


if __name__ == "__main__":
    main()