

def sterge_ore(dict, cinema, film, *hours):

    for ora in hours:
        dict[cinema][film].remove(ora)

    print(cinema, dict[cinema])


def compar_ore(ora1, ora2):
    h1, m1 = ora1.split(":")
    h1, m1 = int(h1), int(m1)

    h2, m2 = ora2.split(":")
    h2, m2 = int(h2), int(m2)

    if h1 > h2:
        return h1 > h2
    if h1 == h2:
        return m1 >= m2
    return h1 > h2


def cinema_film(dict, *cinemas, ora_minima, ora_maxima):

    result = []

    for cinema in cinemas:
        for film in dict[cinema]:
            lst = []
            for ora in dict[cinema][film]:
                if compar_ore(ora, ora_minima) == True and compar_ore(ora, ora_maxima) == False:
                    lst.append(ora)
            if len(lst) != 0:
                lst.sort()
                result.append((film, cinema, lst))
    
    return sorted(result, key=lambda x: (x[0], -len(x[2])))


def main():
    dict = {}

    with open("cinema.in", "r") as f:
        lines = f.readlines()

        for line in lines:
            cinema, film, ore = line.split("%")
            
            cinema = cinema.strip()
            film = film.strip()
            ore = ore.split()

            if dict.get(cinema) is not None:
                dict[cinema].update({film : ore})
            else:
                dict[cinema] = {film : ore}
    
    for cinema in dict:
        print(cinema, dict[cinema])

    # sterge_ore(dict, "Cinema 2", "Minionii 2", "15:00", "20:30")

    print()
    for cinema in dict:
        print(cinema, dict[cinema])

    print(cinema_film(dict, "Cinema 1", "Cinema 2", ora_minima="14:00", ora_maxima="22:00"))



if __name__ == "__main__":
    main()