import random

def move_pvt(start, end, lst):
    i = start
    j = end
    
    addi = 0
    addj = -1

    while i < j:
        if lst[i] > lst[j]:
            lst[i], lst[j] = lst[j], lst[i]
            
            addi, addj = -addj, -addi
        i += addi
        j += addj

    return i


def quicksort(lst, start=0, end=None):
    if end is None:
        end = len(lst) - 1

    if start >= end:
        return

    pvt = random.randint(start, end)
    lst[start], lst[pvt] = lst[pvt], lst[start]

    poz_pvt = move_pvt(start, end, lst)
    quicksort(lst, start, poz_pvt - 1)
    quicksort(lst, poz_pvt + 1, end)




def main():
    lst = [42, 17, 8, 99, 23, 56, 4, 78, 12, 1, 67, 34, 5, 89, 21, 3, 73, 50, 16, 9, 88, 27, 40, 2, 95]


    quicksort(lst)

    print(lst)


if __name__ == "__main__":
    main()