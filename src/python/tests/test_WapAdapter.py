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
        query = WapAdapter.makeQuery("Pi")
        for p in WapAdapter.getPods(query):
            print("pod:", p.Title())
            for sp in WapAdapter.getSubPods(p):
                print("subpod:", sp.Plaintext())


if __name__ == "__main__":
    #import sys;sys.argv = ['', 'Test.testName']
    unittest.main()