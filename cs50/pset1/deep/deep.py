substrings = ["42", "forty-two", "forty two"]

def main():
    string = input("What is the Answer to the Great Question of Life, the Universe, and Everything?")
    string = string.lower()
    if any(elem in string for elem in substrings):
        print("Yes")
    else:
        print("No")

main()
