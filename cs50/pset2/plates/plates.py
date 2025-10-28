

def main():
    plate = input("Plate: ")
    if is_valid(plate):
        print("Valid")
    else:
        print("Invalid")


def is_valid(s):
    if len(s) > 6 or len(s) < 2:
        return False
    for ch in s:
        if ch in " .,!?:;":
            return False

    if (not s[0].isalpha()) or (not s[1].isalpha()):
        return False
    
    for ch in s:
        if ch.isdigit():
            if ch == "0":
                return False
            else:
                break
    
    reversed = s[::-1]
    if reversed[0].isdigit():
        i = 0
        while reversed[i].isdigit():
            i += 1
        for index in range(i, len(reversed)):
            if reversed[index].isdigit():
                return False
    else:
        for index in range(0, len(reversed)):
            if reversed[index].isdigit():
                return False
    
    return True


if __name__ == "__main__":
    main()