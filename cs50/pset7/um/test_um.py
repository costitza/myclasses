import pytest
from um import count


def test_single_um():
    assert count("um") == 1
    assert count("Um") == 1
    assert count("UM") == 1


def test_multiple_um():
    assert count("um um um") == 3
    assert count("Um, um. UM!") == 3


def test_um_as_part_of_word():
    assert count("yummy") == 0
    assert count("umbrella") == 0
    assert count("album") == 0


def test_sentences():
    assert count("Um, I think, um... that's fine.") == 2
    assert count("Um? Um! Um.") == 3


def test_no_um():
    assert count("") == 0
    assert count("hello world") == 0
    assert count("hmm, hmm") == 0
