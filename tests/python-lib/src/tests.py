import unittest
import python_lib
import info.gianlucacosta.eos.core.logic.ranges as ranges

class TestPythonLib(unittest.TestCase):

    def test_hello(self):
        self.assertEqual(python_lib.hello(), 'Hello from 🐍Python!')

    def test_my_sum(self):
        self.assertEqual(python_lib.my_sum(90, 2), 92)


class TestDependencyImports(unittest.TestCase):

    def test_import(self):
        range = ranges.InclusiveRange(lower=7, upper=90)

        self.assertEqual(range.lower, 7)
        self.assertEqual(range.upper, 90)

if __name__ == '__main__':
    unittest.main()