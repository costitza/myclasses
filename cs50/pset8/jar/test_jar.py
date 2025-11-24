import pytest
from jar import Jar

def test_init():
    jar = Jar()
    assert jar.capacity == 12
    assert jar.size == 0

def test_custom_capacity():
    jar = Jar(20)
    assert jar.capacity == 20
    assert jar.size == 0

def test_invalid_capacity_negative():
    with pytest.raises(ValueError):
        Jar(-5)

def test_invalid_capacity_not_int():
    with pytest.raises(ValueError):
        Jar("cookies")

def test_deposit():
    jar = Jar(10)
    jar.deposit(3)
    assert jar.size == 3

def test_deposit_to_limit():
    jar = Jar(5)
    jar.deposit(5)
    assert jar.size == 5

def test_deposit_exceeds_capacity():
    jar = Jar(5)
    with pytest.raises(ValueError):
        jar.deposit(6)

def test_deposit_negative():
    jar = Jar()
    with pytest.raises(ValueError):
        jar.deposit(-1)

def test_withdraw():
    jar = Jar()
    jar.deposit(5)
    jar.withdraw(3)
    assert jar.size == 2

def test_withdraw_exact_amount():
    jar = Jar(5)
    jar.deposit(5)
    jar.withdraw(5)
    assert jar.size == 0

def test_withdraw_too_many():
    jar = Jar(5)
    jar.deposit(3)
    with pytest.raises(ValueError):
        jar.withdraw(4)

def test_str():
    jar = Jar()
    assert str(jar) == ""

def test_str_some_cookies():
    jar = Jar()
    jar.deposit(3)
    assert str(jar) == "🍪🍪🍪"

def test_str_full_capacity():
    jar = Jar(4)
    jar.deposit(4)
    assert str(jar) == "🍪🍪🍪🍪"
