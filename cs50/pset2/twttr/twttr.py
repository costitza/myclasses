

def main():
    str = input("Input: ").split()
    result = []
    for word in str:
        new_word = ""
        for letter in word:
            if letter not in "aeiouAEIOU":
                new_word += letter
        result.append(new_word)
    print(f"Output: {" ".join(result)}")


if __name__ == "__main__":
    main()