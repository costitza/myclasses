from twttr import shorten

def test_shorten():
    assert shorten("hello") == "hll"
    assert shorten("CS50") == "CS50"
    assert shorten("AEIOUaeiou") == ""
    assert shorten("Python is fun!") == "Pythn s fn!"
    assert shorten("") == ""