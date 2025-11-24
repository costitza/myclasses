from numb3rs import validate

def test_validate_valid_ip():
    
    assert validate("192.168.0.1") is True
    assert validate("255.255.255.255") is True
    assert validate("0.0.0.0") is True
    assert validate("256.1.1.1") is False
    assert validate("1.1.1.300") is False
    assert validate("192.168.1") is False
    assert validate("abc.def.ghi.jkl") is False