import inflect

def get_names():
    names = []
    while True:
        try:
            name = input()
            names.append(name)
        except EOFError:
            break
    return names

def main():
    p = inflect.engine()
    names = get_names()
    print("Adieu, adieu, to " + p.join(names))


if __name__ == "__main__":
    main()