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
2. Update the rating of an existing movie (search by title or id)
3. Delete a movie (by id)
4. List movies from genre
5. Export movie library to PDF
6. Exit

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
    '''
    Add a movie using the IMDb ID
    '''
    pattern = r"^tt\d{7}$"
    str = input("Add movie by IMDb id: ")

    if re.match(pattern, str, flags=re.IGNORECASE) is None:
        print("Invalid IMDb ID format. Example: tt0133093")
        return
    
    movies = load_from_json()
    titles = [movie["title"] for movie in movies]
    movie = search_movie(str)

    if movie is None:
        print("Movie not found.")
        return
    if movie["title"] in titles:
        print("Movie is already in the library.")
        return

    rate = input("Give it a rating: ")

    if int(rate) and 0 <= int(rate) <= 10:
        movie["rating"] = rate
    else:
        movie["rating"] = "N/A"

    movie["id"] = str
    
    add_movie(movie)
    print("Movie added succesfully!")
    return



def menu_2():
    '''
    Update the rating on a movie
    '''
    key = input("Movie you want to update the rating on (title or id): ")

    movies = load_from_json()
    idx = next(
        (i for i, m in enumerate(movies)
         if m.get("title", "").lower() == key.lower()
         or m.get("id", "").lower() == key.lower()),
        None
    )
    
    if idx is None:
        print("Movie not found.")
        return

    rate = input("Give it a rating: ")

    if int(rate) and 0 <= int(rate) <= 10:
        movies[idx]["rating"] = rate
    else:
        print("Invalid rating (0-10)")
        return

    save_to_json(movies)
    print("Rating saved succesfully!")




def menu_3():
    '''
    Delete movie from library
    '''
    key = input("Movie you want to delete (title): ")
    movies = load_from_json()
    titles = [movie["title"] for movie in movies]

    if key not in titles:
        print("Movie not found")
        return

    delete_movie(key)
    print("Movie removed succesfully!")




def menu_4():
    ...



def menu_5():
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
            client = input("Enter choice (1-6): ")
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
                    menu_5()
                case "6":
                    exit_function()
                case _:
                    print("Invalid request.")
                    pass
    except EOFError:
        sys.exit("Program exited without saving!!")



if __name__ == "__main__":
    main()
