import re
import sys


def main():
    print(convert(input("Hours: ")))

def verify_time(hour, minute, period):
    if hour < 1 or hour > 12:
        return False
    if minute < 0 or minute > 59:
        return False
    if period not in ["AM", "PM"]:
        return False
    return True

def convert(s):
    pattern = r"^([1-9]?[0-9]*)(:[0-9]{2})? (AM|PM) to ([1-9]?[0-9]*)(:[0-9]{2})? (AM|PM)$"
    match = re.match(pattern, s)
    if not match:
        raise ValueError("Invalid input format")

    start_hour = int(match.group(1))
    start_minute = int(match.group(2)[1:]) if match.group(2) else 0
    start_period = match.group(3)
    end_hour = int(match.group(4))
    end_minute = int(match.group(5)[1:]) if match.group(5) else 0
    end_period = match.group(6)

    if not verify_time(start_hour, start_minute, start_period) or not verify_time(end_hour, end_minute, end_period):
        raise ValueError("Invalid time values")

    if start_period == "PM" and start_hour != 12:
        start_hour += 12
    elif start_period == "AM" and start_hour == 12:
        start_hour = 0
    if end_period == "PM" and end_hour != 12:
        end_hour += 12
    elif end_period == "AM" and end_hour == 12:
        end_hour = 0
    return f"{start_hour:02}:{start_minute:02} to {end_hour:02}:{end_minute:02}"
    



if __name__ == "__main__":
    main()