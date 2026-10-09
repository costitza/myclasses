text = input("Text de decodificat: ")
k = int(input("Cheia k: "))

sol = ""
skip_chars = " ,!?:'."

for ch in text:
    if ch in skip_chars:
        sol += ch
    elif ch.islower():
        sol += chr((ord(ch) - ord('a') - k) % 26 + ord('a'))
    elif ch.isupper():
        sol += chr((ord(ch) - ord('A') - k) % 26 + ord('A'))
    else:
        sol += ch

print(sol)
