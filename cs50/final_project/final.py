import requests
from fpdf import FPDF
import sys
import json
import re



def user_prompt():
    return f"""
🎬 Welcome to Movie Manager!

Please choose an option:

1. Add a new movie (by iMDB id)
2. Update the rating of an existing movie
3. Delete a movie
4. Export movie library to PDF
5. Exit

    """



def load_api_key(config_path="config.json"):
    try:
        with open(config_path, "r") as file:
            config = json.load(file)
            return config["API_KEY"]
    except FileNotFoundError:
        raise FileNotFoundError("Missing config.json file with API key.")
    except KeyError:
        raise KeyError("API_KEY not found in config.json")



def search_movie(id):
    url = f"http://www.omdbapi.com/?i={id}&apikey={API_KEY}"
    response = requests.get(url)

    movie = response.json()
    if movie.get("Response") == "False":
        return None
    return {
        "title": movie.get("Title"),
        "year": movie.get("Year"),
        "genre": movie.get("Genre"),
        "runtime": movie.get("Runtime"),
        "director": movie.get("Director"),
        "actors": movie.get("Actors"),
        "plot": movie.get("Plot")
    }



def load_from_json(path="movies.json"):
    try:
        with open(path, "r") as read:
            return json.load(read)
    except FileNotFoundError:
        return []



def save_to_json(data, path="movies.json"):
    with open(path, "w") as write:
        json.dump(data, write, indent=4)



def add_movie(movie):
    movies = load_from_json()
    movies.append(movie)
    save_to_json(movies)



def delete_movie(title, path="movies.json"):
    movies = load_from_json()
    new_lst = [movie for movie in movies if movie["title"].lower() != title.lower()]
    save_to_json(new_lst)



def export_to_pdf():
    ...




def menu_1():
    pattern = r"^tt\d{7}$"
    str = input("Add movie by IMDb id: ")

    if re.match(pattern, str, flags=re.IGNORECASE) is None:
        print("Invalid IMDb ID format. Example: tt0133093")
        return
    
    movie = search_movie(str)

    if movie is None:
        print("Movie not found.")
        return
    
    add_movie(movie)
    print("Movie added succesfully!")
    return



def menu_2():
    ...



def menu_3():
    ...



def menu_4():
    ...


def exit_function():
    '''
    Saves the json database to pdf and then exits using sys.exit()
    '''
    export_to_pdf()
    sys.exit("Goodbye!")



API_KEY = load_api_key()



def main():
    try:
        while True:
            print(user_prompt())
            client = input("Enter choice (1-5): ")
            match client:
                case "1":
                    menu_1()
                case "2":
                    menu_2()
                case "3":
                    menu_3()
                case "4":
                    menu_4()
                case "5":
                    exit_function()
                case _:
                    print("Invalid request.")
                    pass
    except EOFError:
        sys.exit("Program exited without saving!!")



if __name__ == "__main__":
    main()
