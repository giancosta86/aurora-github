from contextlib import contextmanager
from os import chdir, getcwd


@contextmanager
def switch_to(target_path):
    previous_path = getcwd()

    chdir(target_path)

    try:
        yield
    finally:
        chdir(previous_path)
