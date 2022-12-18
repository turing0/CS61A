# Return

def end(n, d):
    """Print the final digits of N in reverse order until D is found.

    >>> end(34567, 5)
    7
    6
    5
    """
    while n > 0:
        last, n = n % 10, n // 10
        print(last)
        if d == last:
            return None

def search(f):
    """Return the smallest non-negative integer x for which f(x) is a true value."""
    x = 0
    while True:
        if f(x):
            return x
        x += 1

def is_three(x):
    """Return whether x is three.

    >>> search(is_three)
    3
    """
    return x == 3

def square(x):
    return x * x

def positive(x):
    """A function that is 0 until square(x)-100 is positive.

    >>> search(positive)
    11
    """
    return max(0, square(x) - 100)

# https://www.youtube.com/watch?v=QIh6CyrWhvw&list=PLx38hZJ5RLZfaBTgnl9EdoB3JqZl5c8G3&index=6
def invert(f):
    """Return a function g(y) that returns x such that f(x) == y.

    >>> sqrt = invert(square)
    >>> sqrt(16)
    4
    """
    return lambda y: search(lambda x: f(x) == y)