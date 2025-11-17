from plates import is_valid

def test_valid_plates():
    assert is_valid("CS50") == True
    assert is_valid("AB123") == True
    assert is_valid("HELLO1") == True
    assert is_valid("HELLO") == True

def test_invalid_plates():
    assert is_valid("XY9Z") == False
    assert is_valid("CS50PL") == False
    assert is_valid("C") == False
    assert is_valid("CS05") == False
    assert is_valid("CS50P1A") == False
    assert is_valid("C$50") == False
    assert is_valid("12345") == False
    assert is_valid("CS5A0") == False
    assert is_valid("AB0CD") == False
    assert is_valid("BU??!") == False