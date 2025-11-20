def main():
    time = input("What time is it? ")

    time_converted = convert(time)
    # print(time_converted)

    if 7 <= time_converted <= 8:
        print("Breakfast time")
    elif 12 <= time_converted <= 13:
        print("Lunch time")
    elif 18 <= time_converted <= 19:
        print("Dinner time")




def convert(time):
    time = time.split(':')

    hour = int(time[0])
    minute = int(time[1])
    return round(float(hour + ((minute * 100) / 60) / 100), 2)


if __name__ == "__main__":
    main()
