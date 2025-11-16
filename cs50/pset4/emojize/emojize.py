import emoji

def main():
    string = input("Input: ")
    print("Output: ", emoji.emojize(string, language='alias'))

if __name__ == "__main__":
    main()