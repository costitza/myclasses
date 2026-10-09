
def lower(lst, st, dr, x):
    while st <= dr:
        mid = (st + dr) // 2
        if lst[mid] >= x:
            dr = mid - 1
        else:
            st = mid + 1
    return st


def upper(lst, st, dr, x):
    while st <= dr:
        mid = (st + dr) // 2
        if lst[mid] > x:
            dr = mid - 1
        else:
            st = mid + 1
    return dr


def aparitii(lst, x):
    lower_bound = lower(lst, 0, len(lst)-1, x)
    upper_bound = upper(lst, 0, len(lst)-1, x)

    return upper_bound - lower_bound + 1



def main():
    lst = [1, 1, 2, 2, 2, 2, 6, 9, 9, 20]

    print(aparitii(lst, 1))


if __name__ == "__main__":
    main()