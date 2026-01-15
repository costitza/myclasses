
n = 3
G = 10
k = 4

def bkt(solutie, sum_cur, minim, maxim):

    if len(solutie) == n - 1:

        ultim = G - sum_cur

        if ultim < 1:
            return

        minim = min(minim, ultim)
        maxim = max(maxim, ultim)

        if maxim - minim > k:
            return
        
        solutie.append(ultim)
        solutie = [str(elem) for elem in solutie]
        print(" + ".join(solutie))
        return
    
    if len(solutie) != 0:
        max_p = min(minim + k, G)
        min_p = max(maxim - k, 1)
    else:
        max_p = G
        min_p = 1

    if max_p < min_p:
        max_p, min_p = min_p, max_p
    
    for weight in range(min_p, max_p + 1):

        if len(solutie) == 0:
            new_maxim = weight
            new_minim = weight
        else:
            new_maxim = max(maxim, weight)
            new_minim = min(minim, weight)
        
        if new_maxim - new_minim <= k:
            bkt(solutie + [weight], sum_cur + weight, new_minim, new_maxim)


def main():
    bkt([], 0, 10000000, -1)



if __name__ == "__main__":
    main()