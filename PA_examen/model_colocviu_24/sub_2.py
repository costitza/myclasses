
def playlist(dict, *args, durata_minima = 2, durata_maxima = 3):
    rez = []
    for gen in args:
        for artist in dict[gen]:
            for mel in dict[gen][artist]:
                if durata_minima <= mel[1] <= durata_maxima or mel[1] == durata_maxima and mel[2] == 0:
                    if mel[2] == 0:
                        time = "0" + str(mel[1]) + ":00"
                    else:
                        time =  "0" + str(mel[1]) + ":" + str(mel[2])
                    rez.append((gen, artist, mel[0], time))
    return rez


def adauga_melodie(dict, gen, artist, melodie, timp):
    min, sec = map(int, timp.split(":"))
    if dict.get(gen) is not None:
        if dict[gen].get(artist) is not None:
            dict[gen][artist].append([melodie, min, sec])
        else:
            dict[gen][artist] = [[melodie, min, sec]]
        print(f"Genul {gen} contine acum {sum([1 for artist in dict[gen] for _ in dict[gen][artist]])} melodii.")
    else:
        print("Nu exista acest gen muzical.")


def main():
    dict = {}
    with open("melodii.in", "r") as f:
        gen = f.readline().removeprefix("Gen >> ").removesuffix("\n")
        
        lines = f.readlines()
        
        for line in lines:
            if "Gen >> " not in line:
                mel, artist, time = line.split(" / ")
                time = time.removesuffix("\n")
                min, sec = map(int, time.split(":"))
                if dict.get(gen) is not None:
                    if dict[gen].get(artist) is not None:
                        dict[gen][artist].append([mel, min, sec])
                    else:
                        dict[gen][artist] = [[mel, min, sec]]

                else:
                    dict[gen] = {artist : [[mel, min, sec]]}
            else:
                gen = line.removeprefix("Gen >> ").removesuffix("\n")
    
    print(*playlist(dict, "Rock", "Hip-hop"))

    adauga_melodie(dict, "Hip-hop", "DGK", "Meet me there", "03:15")
    adauga_melodie(dict, "Pop", "DGK", "Meet me there", "03:15")

    
    print(dict)


if __name__ == "__main__":
    main()