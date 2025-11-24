class Jar:
    def __init__(self, capacity=12):
        if isinstance(capacity, int) and 0 <= capacity:
            self._capacity = capacity
        else:
            raise ValueError
        self._size = 0

    def __str__(self):
        return "".join(["🍪" for _ in range(0, self._size)])

    def deposit(self, n):
        if not isinstance(n, int) or n < 0:
            raise ValueError()
        if self._capacity >= self._size + n:
            self._size += n
        else:
            raise ValueError

    def withdraw(self, n):
        if not isinstance(n, int) or n < 0:
            raise ValueError()
        if self._size - n < 0:
            raise ValueError
        self._size -= n

    @property
    def capacity(self):
        return self._capacity

    @property
    def size(self):
        return self._size