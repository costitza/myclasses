import re
import sys


def main():
    print(parse(input("HTML: ")))


def parse(s):
    pattern = r"^<iframe.* src=\"(?:https?://)(?:www\.)?youtube\.com/embed/(?P<code>[a-zA-Z0-9]+)\".*></iframe.*>$"
    match = re.search(pattern, s)
    if match:
        return f"https://youtu.be/{match.group('code')}"
    else:
        return f"None"
    

if __name__ == "__main__":
    main()