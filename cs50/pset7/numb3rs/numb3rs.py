import re
import sys


def main():
    print(validate(input("IPv4 Address: ")))

def validate(ip):
    pattern = r"^(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]|[1-9]|0)\." \
          r"(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]|[1-9]|0)\." \
          r"(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]|[1-9]|0)\." \
          r"(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]|[1-9]|0)$"
    if match := re.match(pattern, ip):
        for index in range(1, 5):
            if not (0 <= int(match.group(index)) <= 255):
                return False
        return True
            
    return False


if __name__ == "__main__":
    main()