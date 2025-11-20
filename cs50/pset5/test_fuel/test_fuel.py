from ast import Div
import pytest
from fuel import convert, gauge

def test_convert():
    assert convert("1/2") == 50.0   
    assert convert("3/4") == 75.0
    assert convert("2/5") == 40.0
    assert convert("0/1") == 0.0
    assert convert("1/1") == 100.0
    with pytest.raises(ZeroDivisionError):
        convert("3/0")  # Division by zero
    with pytest.raises(ValueError):
        convert("abc")  # Invalid format
    with pytest.raises(ValueError):
        convert("1/a")  # Non-integer denominator
    with pytest.raises(ValueError):
        convert("a/1")  # Non-integer numerator
    with pytest.raises(ValueError):
        convert("5/3")  # Numerator greater than denominator
    with pytest.raises(ValueError):
        convert("-1/2")  # Negative numerator

def test_gauge():
    assert gauge(0) == "E"
    assert gauge(1) == "E"
    assert gauge(50) == "50%"
    assert gauge(99) == "F"
    assert gauge(100) == "F"
    assert gauge(76) == "76%"
