import requests
from fpdf import FPDF
import sys
import json
import re
from fpdf.enums import XPos, YPos


def user_prompt():
    """Return the main menu text shown to the user."""
    return f"""
🎬 Welcome to Movie Manager!

Please choose an option:

1. Add a new movie (by iMDB id)
2. Update the rating of an existing movie (search by title or id)
3. Delete a movie (by title)
4. Save movies from specific genre to PDF
5. Show average rating of library
6. Save top 10 movies to PDF
7. Exit

    """


def load_api_key(config_path="config.json"):
    """Load and return the OMDb API key from a JSON config file.

    Raises:
        FileNotFoundError: If the config file does not exist.
        KeyError: If the API_KEY field is missing from the config.
    """
    try:
        with open(config_path, "r") as file:
            config = json.load(file)
            return config["API_KEY"]
    except FileNotFoundError:
        raise FileNotFoundError("Missing config.json file with API key.")
    except KeyError:
        raise KeyError("API_KEY not found in config.json")


def sanitize_text(s: str) -> str:
    """Return text sanitized to Latin-1 so it is safe for core PDF fonts.

    Replaces common Unicode punctuation with ASCII equivalents and strips
    remaining non-Latin-1 characters.
    """
    if s is None:
        return ""
    replacements = {
        "•": "|",
        "–": "-",
        "—": "-",
        "“": '"',
        "”": '"',
        "‘": "'",
        "’": "'",
        "…": "...",
        "\u00A0": " ",
    }
    for bad, good in replacements.items():
        s = s.replace(bad, good)
    return s.encode("latin-1", "ignore").decode("latin-1")


def search_movie(id):
    """Fetch movie details from OMDb by IMDb ID and return a movie dict.

    Returns:
        dict | None: Normalized movie fields if found, otherwise None.
    """
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
        "plot": movie.get("Plot"),
    }


def load_from_json(path="movies.json"):
    """Load and return the movies list from the JSON database.

    Returns an empty list if the file does not exist.
    """
    try:
        with open(path, "r") as read:
            return json.load(read)
    except FileNotFoundError:
        return []


def save_to_json(data, path="movies.json"):
    """Persist the given movies list to the JSON database."""
    with open(path, "w") as write:
        json.dump(data, write, indent=4)


def add_movie(movie):
    """Append a new movie dict to the JSON database."""
    movies = load_from_json()
    movies.append(movie)
    save_to_json(movies)


def delete_movie(title, path="movies.json"):
    """Delete a movie by title (case-insensitive) from the JSON database."""
    movies = load_from_json()
    new_lst = [movie for movie in movies if movie["title"].lower() != title.lower()]
    save_to_json(new_lst)


def export_to_pdf(movies=None, db_path="movies.json", output="movies.pdf", pdf_title="My Movie Library"):
    """Export movies (all or provided subset) into a styled PDF document.

    Args:
        movies (list|None): Optional list of movie dicts to export. If None, load from db_path.
        db_path (str): Path to JSON database if movies is None.
        output (str): Output PDF file path.
        pdf_title (str): Title displayed in the PDF header.
    """
    if movies is None:
        movies = load_from_json(db_path)
    if not movies:
        print("No movies to export. PDF not created.")
        return

    pdf = FPDF(orientation="P", unit="mm", format="A4")
    pdf.set_auto_page_break(auto=True, margin=15)
    pdf.add_page()
    pdf.set_author("Movie Manager")
    pdf.set_title(pdf_title)

    pdf.set_font("Helvetica", "B", 22)
    pdf.set_text_color(0, 0, 0)
    pdf.set_xy(0, 10)
    pdf.cell(0, 10, pdf_title, align="C", new_x=XPos.LMARGIN, new_y=YPos.NEXT)
    pdf.ln(3)

    LEFT = 12
    pdf.set_font("Helvetica", size=11)

    for m in movies:
        title    = sanitize_text(m.get("title", "Untitled"))
        year     = sanitize_text(m.get("year", "N/A"))
        imdb_id  = sanitize_text(m.get("id", "N/A"))
        genre    = sanitize_text(m.get("genre", "N/A"))
        runtime  = sanitize_text(m.get("runtime", "N/A"))
        director = sanitize_text(m.get("director", "N/A"))
        actors   = sanitize_text(m.get("actors", "N/A"))
        plot     = sanitize_text(m.get("plot", ""))
        rating   = m.get("rating", "N/A")

        pdf.set_font("Helvetica", "B", 14)
        pdf.set_x(LEFT)
        pdf.cell(0, 8, f"{title} ({year})", new_x=XPos.LMARGIN, new_y=YPos.NEXT)

        pdf.set_font("Helvetica", "", 11)
        pdf.set_x(LEFT)
        meta = f"IMDb: {imdb_id} | {runtime} | Director: {director}"
        pdf.cell(0, 6, meta, new_x=XPos.LMARGIN, new_y=YPos.NEXT)

        pdf.set_x(LEFT)
        pdf.cell(0, 6, f"Genre: {genre}", new_x=XPos.LMARGIN, new_y=YPos.NEXT)

        pdf.set_x(LEFT)
        pdf.multi_cell(0, 6, f"Actors: {actors}")

        if plot:
            pdf.ln(1)
            pdf.set_x(LEFT)
            pdf.multi_cell(0, 6, f"Plot: {plot}")

        if isinstance(rating, (int, float)) or (isinstance(rating, str) and rating.isdigit()):
            r = int(rating)
            r = max(0, min(r, 10))
            pdf.ln(1)
            pdf.set_x(LEFT)
            pdf.set_font("Helvetica", "B", 10)
            pdf.cell(0, 6, f"Your rating: {r}/10", new_x=XPos.LMARGIN, new_y=YPos.NEXT)
        elif rating not in (None, "", "N/A"):
            pdf.ln(1)
            pdf.set_x(LEFT)
            pdf.set_font("Helvetica", "B", 10)
            pdf.cell(0, 6, f"Your rating: {sanitize_text(str(rating))}", new_x=XPos.LMARGIN, new_y=YPos.NEXT)

        pdf.ln(2)
        y = pdf.get_y()
        pdf.set_draw_color(220, 220, 220)
        pdf.line(10, y, 200, y)
        pdf.set_draw_color(0, 0, 0)
        pdf.ln(4)

    pdf.output(output)
    print(f"PDF exported to {output}")


def menu_1():
    """Prompt for an IMDb ID, fetch the movie from OMDb, rate it, and add it to the database."""
    pattern = r"^tt\d{7}\d*$"
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
    """Update the rating of a stored movie by title or IMDb ID."""
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
    """Delete a movie from the database by title (case-insensitive)."""
    key = input("Movie you want to delete (title): ")
    movies = load_from_json()
    titles = [movie["title"] for movie in movies]

    if key not in titles:
        print("Movie not found")
        return

    delete_movie(key)
    print("Movie removed succesfully!")


def menu_4():
    """Filter library by a genre, then export that subset to a PDF with a genre-specific title."""
    key = input("Genre you want to filter on: ").strip().lower()
    movies = load_from_json()

    movies_genres = []
    for movie in movies:
        genres = movie["genre"].split(", ")
        genres = [elem.lower() for elem in genres]
        if key in genres:
            movies_genres.append(movie)

    export_to_pdf(movies_genres, output=f"genre_{key}.pdf", pdf_title=f"Movie genre: {key.capitalize()}")
    print("Exported genre succesfully!")


def menu_5():
    """Compute and print the average rating across all movies in the library."""
    movies = load_from_json()
    rating_sum = sum([int(movie["rating"]) for movie in movies])
    counter = sum([1 for _ in movies])
    print(f"The average movie rating is {round(rating_sum / counter, 2)}")


def menu_6():
    """Export the top 5 highest-rated movies (tie-broken by title) to a PDF."""
    movies = load_from_json()
    top_movies = sorted(movies, key=lambda movie: (-int(movie["rating"]), movie["title"].lower()))[:5]
    export_to_pdf(top_movies, output="top_movies.pdf", pdf_title="My top 5 movies")


def exit_function():
    """Export the full library to PDF and terminate the program."""
    export_to_pdf()
    sys.exit("Goodbye!")


API_KEY = load_api_key()


def main():
    """Run the interactive CLI loop until the user exits or sends EOF."""
    try:
        while True:
            print(user_prompt())
            client = input("Enter choice (1-7): ")
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
                    menu_6()
                case "7":
                    exit_function()
                case _:
                    print("Invalid request.")
                    pass
    except EOFError:
        sys.exit("Program exited without saving!!")


if __name__ == "__main__":
    main()
