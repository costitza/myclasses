text = input().lower()
separators = " ,.:;?!"

for sep in separators:
    text = text.replace(sep, " ")

words = text.split()

unique_words = set()

for word in words:
    unique_words.add(word)

print(len(unique_words))
