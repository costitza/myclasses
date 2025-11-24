from datetime import date
import datetime
import re, sys
import inflect

def is_valid_birthday(birthday):
    year, month, day = map(int, birthday.split("-"))
    try:
        date(year, month, day)
        return True
    except ValueError:
        return False

def get_user_birthday():
    pattern = r"^\d\d\d\d-\d\d-\d\d$"

    birthday = input("Date of Birth: ")
    if re.match(pattern, birthday) and is_valid_birthday(birthday):
        return birthday
    else:
        sys.exit("Invalid date format. Please use YYYY-MM-DD.")

def main():
    birthday = get_user_birthday()
    year, month, day = map(int, birthday.split("-"))
    days_lived = (date.today() - date(year, month, day)).days
    # print(days_lived)
    amount_minutes = days_lived * 24 * 60
    # print(amount_minutes)
    print(f"{inflect.engine().number_to_words(amount_minutes, andword="").capitalize()} minutes")


if __name__ == "__main__":
    main()