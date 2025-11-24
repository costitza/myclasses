import pytest
from datetime import date
import inflect

from seasons import is_valid_birthday, get_user_birthday


def test_valid_date():
    assert is_valid_birthday("1999-01-01") is True

def test_invalid_day():
    # February 30 is invalid
    assert is_valid_birthday("2020-02-30") is False

def test_invalid_month():
    assert is_valid_birthday("2020-13-10") is False

def test_invalid_year():
    # Year 0000 is invalid
    assert is_valid_birthday("0000-01-01") is False

def test_get_user_birthday_invalid(monkeypatch):
    # Mock input to supply invalid birthday
    monkeypatch.setattr("builtins.input", lambda _: "1999/01/01")
    
    with pytest.raises(SystemExit):
        get_user_birthday()
