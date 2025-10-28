

def main():
    str = input("camelCase: ")
    list = []
    word = ""
    for ch in str:
        if ch.islower():
            word += ch
        else:
            list.append(word)
            word = ch.lower()
    list.append(word)

    result = "_".join(list)
    print(result)


if __name__ == "__main__":
    main()