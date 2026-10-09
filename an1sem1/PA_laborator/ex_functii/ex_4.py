
def log_mesaj(mesaj, prefix="[INFO]", *args, sep=", ", **kwargs):
    """Afiseaza un mesaj de log cu optiuni flexibile."""
    if prefix == "[INFO]":
        linie = f"{prefix} {mesaj}"
        if args:
            linie += " " + sep.join(str(a) for a in args)
        if kwargs:
            extra = "; ".join(f"{k}={v}" for k, v in kwargs.items())
            linie += f" | {extra}"
        print(linie)
    elif prefix == "[ERROR]":
        linie = f"{prefix} {mesaj.upper()}"
        if args:
            linie += " " + sep.join(str(a).upper() for a in args)
        if kwargs:
            extra = "; ".join(f"{k.upper()}={v.upper()}" for k, v in kwargs.items())
            linie += f" | {extra}"
        print(linie)
    elif prefix == "[DEBUG]":
        linie = f"{prefix} {mesaj.lower()}"
        if args:
            linie += " " + sep.join(str(a).lower() for a in args)
        if kwargs:
            extra = "; ".join(f"{k.lower()}={v.lower()}" for k, v in kwargs.items())
            linie += f" | {extra}"
        print(linie)


def main():
    log_mesaj("Pornire aplicatie")
    log_mesaj("Utilizator conectat", "[DEBUG]", "user123", "IP: 12467812", metoda="OAuth")


if __name__ == "__main__":
    main()