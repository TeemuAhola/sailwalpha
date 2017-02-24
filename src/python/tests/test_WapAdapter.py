'''
Created on Jul 13, 2016

@author: teemu
'''
import unittest
import WapAdapter


class Test(unittest.TestCase):


    def setUp(self):
        pass


    def tearDown(self):
        pass


    def testName(self):
        query = WapAdapter.Query("Pi")

        for p in query.getPods():
            print(p)
            
        for a in query.getAssumptions():
            print(a)



if __name__ == "__main__":
    #import sys;sys.argv = ['', 'Test.testName']
    unittest.main()
