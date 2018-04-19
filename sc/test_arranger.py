import unittest

from arranger import check, arrange

class TestArrangerCheck(unittest.TestCase):
    # test if it returns True if the folder exists, and False if doesn't
    def test_check(self):
        self.assertTrue(check(r'/'), True)
        self.assertFalse(check(r'/doesntexist'), False)

    def test_arrange(self):
        pass
