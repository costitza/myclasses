
def construieste_url(baza, *segmente, **parametri):
    url = baza
    if segmente:
        for segment in segmente:
            url += '/' + segment
    if parametri:
        url += '?'
        param_list = [f"{cheie}={valoare}" for cheie, valoare in parametri.items()]
        url += '&'.join(param_list)
    return url


def main():
    print(construieste_url("https://exemplu.com", "utilizatori", "profil", id=42, activ=True))
    print(construieste_url("https://exemplu.com", "cautare", q="python", pagina=2))

if __name__ == "__main__":
    main()