
w = input().strip()
n = int(input())

length = len(w)


sol = []


for _ in range(n):
    word = input().strip()
    
    if len(word) == length and word not in sol:
        sol.append(word)


print(" ".join(sol))
