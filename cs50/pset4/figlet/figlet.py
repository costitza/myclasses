import sys
from pyfiglet import Figlet

style = ""
f = Figlet()

def verify_arguments():
    global style
    if len(sys.argv) == 3:
        if sys.argv[1] == "-f" or sys.argv[1] == "--font":
            style = sys.argv[2]
        else:
            sys.exit()
    else:
        style = "standard"
    if style not in f.getFonts():
        sys.exit()


def main():
    verify_arguments()
    f = Figlet(font=style)
    string = input("Input: ")
    print(f.renderText(string))

if __name__ == "__main__":
    main()