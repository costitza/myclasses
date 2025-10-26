
def calc(a, b, op):
    match op:
        case '+':
            return float(a + b)
        case '-':
            return float(a - b)
        case '*':
            return float(a * b)
        case '/':
            return float(a / b)

def main():
    string = input("Expression: ").split()
    a = int(string[0])
    b = int(string[-1])
    op = string[1]

    print(f"{calc(a, b, op):.1f}")

main()