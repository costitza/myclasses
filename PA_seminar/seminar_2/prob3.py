text = input()

semne = ",.:;?!"

nrlmici = sum(1 for c in text if c.islower())
nrlmari = sum(1 for c in text if c.isupper())
nrsemne = sum(1 for c in text if c in semne)

print(nrlmici)
print(nrlmari)
print(nrsemne)
