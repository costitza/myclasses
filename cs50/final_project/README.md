# Movie Manager (CS50P Final Project)
#### Video Demo: <PUT YOUR YOUTUBE URL HERE>
#### Description:
**Movie Manager** is a command-line application for building and maintaining a personal movie library, powered by the OMDb API. You can add films by IMDb ID, assign your own rating, update or delete entries, filter by genre, compute the library’s average rating, and export any subset (or the whole collection) to a clean, readable PDF via `fpdf2`. Data is stored locally in `movies.json`, and your OMDb API key lives in a separate `config.json`.

---

## Features

- **Add by IMDb ID**  
  Enter an ID like `tt0133093` and the app fetches title, year, genre, runtime, director, actors, and plot from OMDb.

- **Personal Ratings (0–10)**  
  Rate a movie when you add it, and update the rating later by title or IMDb ID.

- **Edit & Delete**  
  Update rating (menu option 2) or delete by title (menu option 3).

- **Filter & Export to PDF**  
  Export movies from a chosen genre to a PDF with a custom title, or export your top-rated picks.

- **Statistics**  
  Show the average rating across your library.

- **Top Picks**  
  Export your top N (configured as top 5/10) highest-rated movies to a PDF.

- **PDF Output**  
  Generates a nicely formatted PDF using `fpdf2`, safe for core fonts (Latin-1) via a `sanitize_text` helper.

---

## Project Structure

- **`project.py`** (or **`final.py`**): main program that contains:
  - `main()` with the interactive menu/loop.
  - `load_api_key()` to pull the OMDb key from `config.json`.
  - `search_movie(id)` to fetch movie data from OMDb.
  - Persistence helpers: `load_from_json()`, `save_to_json()`.
  - Library actions: `add_movie()`, `delete_movie()`, plus menu handlers `menu_1` … `menu_6`.
  - PDF export: `export_to_pdf(movies=None, db_path="movies.json", output="movies.pdf", pdf_title="...")`.
  - `sanitize_text()` to replace Unicode punctuation for Latin-1 PDF fonts.
  - `exit_function()` to export and quit gracefully.

- **`movies.json`**: the local database (list of movie dicts). Created on demand.

- **`config.json`**: holds your OMDb `API_KEY`. You create this (see Setup). Keep it out of GitHub via `.gitignore`.

- **`requirements.txt`**: Python dependencies (`requests`, `fpdf2`).

- **`test_project.py`** *(optional but recommended)*: pytest tests for JSON I/O, sorting, and export.

---

## Setup

1. **Create and activate a virtual environment (optional)**  
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate      # Windows: .venv\Scripts\activate
2. **Install dependencies**

    ```bash
    Copy code
    pip install -r requirements.txt

Get an OMDb API key  
Request a free key at https://www.omdbapi.com/apikey.aspx.

Create `config.json` in your project folder:

```json
{
  "API_KEY": "YOUR_OMDB_API_KEY_HERE"
}
```

(Recommended) `.gitignore`

```bash
**/config.json
**/movies.json
__pycache__/
*.pyc
```

## Usage

Run the program:

```bash
python project.py
```

You’ll see:

```
🎬 Welcome to Movie Manager!

1. Add a new movie (by iMDB id)
2. Update the rating of an existing movie (search by title or id)
3. Delete a movie (by title)
4. Save movies from specific genre to PDF
5. Show average rating of library
6. Save top 10 movies to PDF
7. Exit
```

## Typical flows

Add → `1` → enter IMDb ID (e.g., tt0816692) → enter rating.

Update → `2` → enter title or ID → enter new rating.

Delete → `3` → enter title.

Export by Genre → `4` → enter genre (e.g., Sci-Fi) → creates `genre_sci-fi.pdf`.

Average Rating → `5`.

Top Movies → `6` → creates `top_movies.pdf`.

Exit → `7` → exports the full library to `movies.pdf`.

## Data Model

Each movie is stored as a dictionary. Example:

```json
{
  "id": "tt0133093",
  "title": "The Matrix",
  "year": "1999",
  "genre": "Action, Sci-Fi",
  "runtime": "136 min",
  "director": "Lana Wachowski, Lilly Wachowski",
  "actors": "Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss",
  "plot": "A computer hacker learns about the true nature of reality...",
  "rating": 9
}
```

Notes:

- `rating` is your score (int 0–10). Unrated may be `"N/A"`.
- `id` is the IMDb ID. Duplicate prevention can be done by checking this field.

## Design Choices

- JSON storage: Simple, human-readable, easy to test.
- Config isolation: `config.json` keeps secrets out of code; easy `.gitignore`.
- `sanitize_text` for PDFs: Core fpdf2 fonts are Latin-1; sanitization avoids Unicode errors without bundling TTFs.
- Deterministic exports: The exporter can respect pre-sorted lists (for top-N) or load and sort internally when desired.

## Testing (Recommended)

With pytest, you can validate:

- JSON I/O (`load_from_json`, `save_to_json`)
- OMDb parsing (mock `requests.get`)
- Sorting helpers (rating desc, title asc)
- PDF export existence/size

Example:

```bash
pytest -q
```

## Requirements

Python 3.10+  
`requests`  
`fpdf2`

Install with:

```bash
pip install -r requirements.txt
```

## Known Limitations & Future Work

- Core fonts limit Unicode; optionally embed a TTF (e.g., DejaVuSans) to support bullets/emoji/non-Latin titles.
- Better duplicate handling by IMDb ID across add/update flows.
- Optional poster download and inclusion in PDFs.
- CLI flags via argparse for non-interactive usage (`--add tt0133093 --rate 9`).
- Extra analytics: per-genre averages, watch-time estimates, and a “random pick.”

## Acknowledgments

- OMDb API — Open Movie Database  
- fpdf2 — PDF generation library  
- CS50P — for project inspiration and scaffolding
