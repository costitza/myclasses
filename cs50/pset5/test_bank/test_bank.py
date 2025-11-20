from bank import value

def test_bank():
    assert value("hello") == 0
    assert value("Hello") == 0
    assert value("  hello  ") == 0
    assert value("hi") == 20
    assert value("Hey") == 20
    assert value("  howdy  ") == 20
    assert value("good morning") == 100
    assert value("bye") == 100
    assert value("  farewell  ") == 100