from working import convert
import pytest

def test_convert():
    assert convert("9 AM to 5 PM") == "09:00 to 17:00"
    assert convert("12:30 PM to 1:15 AM") == "12:30 to 01:15"
    assert convert("1:05 AM to 11:59 PM") == "01:05 to 23:59"
    assert convert("12 AM to 12 PM") == "00:00 to 12:00"
    assert convert("11:45 PM to 12:15 AM") == "23:45 to 00:15"
    
    with pytest.raises(ValueError):
        convert("13 AM to 5 PM")
    with pytest.raises(ValueError):
        convert("9 AM to 12:60 PM")
    with pytest.raises(ValueError):
        convert("9 AM - 5 PM")
    with pytest.raises(ValueError):
        convert("9AM to 5PM")

if __name__ == "__main__":
    pytest.main()