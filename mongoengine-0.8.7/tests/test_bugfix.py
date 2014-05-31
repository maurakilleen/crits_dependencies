import unittest
import sys
sys.path[0:0] = [""]

from mongoengine import *
from mongoengine.connection import get_db
from mongoengine.queryset import transform
from datetime import datetime, timedelta
from bson import SON
import decimal

import os

__all__ = ("DynamicTest", )


class DynamicTest(unittest.TestCase):

    def setUp(self):
        connect(db='mongoenginetest')
        self.db = get_db()

    def test_shard_key(self):

        class Foo(Document):
            pass

        f = Foo()
        try:
            f.reload()
        except Foo.DoesNotExist:
            pass
        except Exception as ex:
            self.assertFalse("Threw wrong exception")

        f.save()
        f.delete()
        try:
            f.reload()
        except Foo.DoesNotExist:
            pass
        except Exception as ex:
            self.assertFalse("Threw wrong exception")






if __name__ == '__main__':
    unittest.main()
