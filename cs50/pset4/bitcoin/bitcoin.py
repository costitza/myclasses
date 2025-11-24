import sys
import requests

url = "https://rest.coincap.io/v3/assets/bitcoin"
headers = {
    "Authorization": f"Bearer 46b46bf88a17350b643c8c202be111543dbdadfb252b25e0efbfe68fa18f553f"
}

def get_float():
    if len(sys.argv) != 2:
        sys.exit("Usage: python bitcoin.py <amount>")
    try:
        amount = float(sys.argv[1])
        if amount < 0:
            raise ValueError
        return amount
    except ValueError:
        sys.exit("Amount must be a non-negative number")


def main():
    bitcoin_amount = get_float()

    try:
        response = requests.get(url, headers = headers)
        response.raise_for_status()
    except requests.RequestException:
        sys.exit("Error fetching Bitcoin price")


    data = response.json()
    # print(data)

    try:
        bitcoin_price = float(data["data"]["priceUsd"])
    except (KeyError, IndexError, ValueError):
        sys.exit("Error parsing Bitcoin price")


    if bitcoin_amount is not None:
        print(f"${bitcoin_amount * bitcoin_price:,.4f}")

if __name__ == "__main__":
    main()
