def main():
    tweet = input("Input: ")
    print("Output:", shorten(tweet))


def shorten(word):
    new_word = ""
    for letter in word:
        if letter not in "aeiouAEIOU":
            new_word += letter
    return "".join(new_word)


if __name__ == "__main__":
    main()