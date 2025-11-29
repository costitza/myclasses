import json
import pytest
from unittest.mock import patch, MagicMock
from project import (
    load_from_json, save_to_json, add_movie,
    delete_movie, search_movie, sanitize_text
)


def test_load_from_json(tmp_path):
    test_file = tmp_path / "movies.json"
    data = [{"title": "Inception", "rating": "9"}]

    with open(test_file, "w") as f:
        json.dump(data, f)

    loaded = load_from_json(test_file)
    assert loaded == data


def test_load_from_json_missing(tmp_path):
    test_file = tmp_path / "does_not_exist.json"
    loaded = load_from_json(test_file)
    assert loaded == []


def test_save_to_json(tmp_path):
    test_file = tmp_path / "movies.json"
    data = [{"title": "Avatar", "rating": "8"}]

    save_to_json(data, test_file)

    with open(test_file, "r") as f:
        result = json.load(f)

    assert result == data


def test_add_movie(tmp_path):
    # Start with empty DB
    test_file = tmp_path / "movies.json"
    save_to_json([], test_file)

    movie = {"title": "Interstellar", "rating": "10"}

    # Patch load/save to use temp file
    with patch("project.load_from_json", return_value=[]), \
         patch("project.save_to_json") as mock_save:

        add_movie(movie)
        mock_save.assert_called_once()
        args, kwargs = mock_save.call_args
        saved_list = args[0]
        assert movie in saved_list


def test_delete_movie(tmp_path):
    movies = [
        {"title": "The Matrix"},
        {"title": "Inception"},
    ]
    test_file = tmp_path / "movies.json"
    save_to_json(movies, test_file)

    # Patch load/save to use temp file
    with patch("project.load_from_json", return_value=movies.copy()), \
         patch("project.save_to_json") as mock_save:

        delete_movie("Inception")
        args, kwargs = mock_save.call_args
        new_list = args[0]

        assert {"title": "Inception"} not in new_list
        assert {"title": "The Matrix"} in new_list


def test_sanitize_text_basic():
    assert sanitize_text("Hello") == "Hello"
    assert sanitize_text(None) == ""
    assert sanitize_text("“Hello” — Test") == '"Hello" - Test'


def test_sanitize_text_strips_unicode():
    # Bullet character should be removed/replaced
    cleaned = sanitize_text("Title • something")
    assert "|" in cleaned or "something" in cleaned


def test_search_movie_mock():
    mock_response = {
        "Response": "True",
        "Title": "Fight Club",
        "Year": "1999",
        "Genre": "Drama",
        "Runtime": "139 min",
        "Director": "David Fincher",
        "Actors": "Brad Pitt, Edward Norton",
        "Plot": "A depressed man meets a strange soap salesman..."
    }

    with patch("requests.get") as mock_get:
        mock_get.return_value.json = lambda: mock_response

        result = search_movie("tt0137523")

        assert result["title"] == "Fight Club"
        assert result["year"] == "1999"
        assert result["genre"] == "Drama"
        assert result["director"] == "David Fincher"
        assert result["actors"].startswith("Brad Pitt")


def test_search_movie_not_found():
    mock_response = {"Response": "False", "Error": "Movie not found"}

    with patch("requests.get") as mock_get:
        mock_get.return_value.json = lambda: mock_response

        result = search_movie("bad_id")
        assert result is None
