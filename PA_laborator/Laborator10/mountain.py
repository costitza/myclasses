
def mountain_peak(lst, st = 0, dr = None):
    if dr == None:
        dr = len(lst) - 1
    
    if st == dr:
        return st

    mid = (dr + st) // 2

    if lst[mid] < lst[mid + 1]:
        return mountain_peak(lst, mid + 1, dr)
    else:
        return mountain_peak(lst, st, mid)


def main():
    lst = [4, 8, 10, 9, 5]
    print(mountain_peak(lst))


if __name__ == "__main__":
    main()