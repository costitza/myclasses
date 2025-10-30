import re

months = {
    "january": "01",
    "february": "02",
    "march": "03",
    "april": "04",
    "may": "05",
    "june": "06",
    "july": "07",
    "august": "08",
    "september": "09",
    "october": "10",
    "november": "11",
    "december": "12"
}

def check_normal(date):
    date = date.split("/")

    month = date[0]
    day = date[1]
    year = date[2]

    if int(month) >= 12:
        return False
    if int(day) >= 31:
        return False
    return True

def check_month(date):
    date = date.replace(",", "")
    date = date.split(" ")

    month = str(date[0].lower())
    day = date[1]
    year = date[2]
    
    if int(day) > 31:
        return False
    if months[month] is None:
        return False
    return True


def get_string(prompt):
    normal_pattern = r"^\d{1,2}/\d{1,2}/\d{4}$"
    month_pattern = r"^[A-Z][a-z]+ [0-9]{1,2}, \d{4}$"
    while True:
        try:
            date = input(prompt).strip()
            if re.match(normal_pattern, date):
                if check_normal(date) == True:
                    return "normal", date
                else:
                    raise ValueError
            elif re.match(month_pattern, date):
                if check_month(date) == True:
                    return "month", date
                else:
                    raise ValueError
            else:
                raise ValueError
        except ValueError as e:
            pass


def convert_normal(date):
    date = date.split("/")

    month = date[0]
    day = date[1]
    year = date[2]

    if int(month) < 10:
        month = "0" + month
    if int(day) < 10:
        day = "0" + day
    return year + "-" + month + "-" + day


def convert_month(date):
    date = date.replace(",", "")
    date = date.split(" ")

    month = months[date[0].lower()]
    day = date[1]
    year = date[2]
    
    if int(day) < 10:
        day = "0" + day
    return year + "-" + month + "-" + day


def main():
    style, date = get_string("Date: ")
    if(style == "month"):
        print(convert_month(date))
    else:
        print(convert_normal(date))


if __name__ == "__main__":
    main()