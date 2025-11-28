
from tracemalloc import stop


def merge(lst, starti, stopi, startj, stopj):
    i = starti
    j = startj
    new_lst = []
    while i <= stopi and j <= stopj:
        if lst[i] > lst[j]:
            new_lst.append(lst[j])
            j += 1
        else:
            new_lst.append(lst[i])
            i += 1
    while i <= stopi:
        new_lst.append(lst[i])
        i += 1
    while j <= stopj:
        new_lst.append(lst[j])
        j += 1

    lst[starti : stopj + 1] = new_lst
    


def mergesort(lst, start, end):
    if start >= end:
        return
    
    middle = start + (end - start) // 2

    mergesort(lst, start, middle)
    mergesort(lst, middle + 1, end)

    merge(lst, start, middle, middle + 1, end)


def main():
    lst = [42, 17, 8, 99, 23, 56, 4, 78, 12, 1, 67, 34, 5, 89, 21, 3, 73, 50, 16, 9, 88, 27, 40, 2, 95]

    mergesort(lst, 0, len(lst) - 1)
    print(lst)


if __name__ == "__main__":
    main()