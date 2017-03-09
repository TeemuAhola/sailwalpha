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
        query = WapAdapter.makeSimpleQuery("Pi")
        self.assertTrue(query.isSuccess)           
        WapAdapter.saveQuery(query, "/tmp/f.bin")
        
        query2 = WapAdapter.loadQuery("/tmp/f.bin")
        
        self.assertTrue(query2.isSuccess)        

        for p in query.pods:
            print(p)
   

if __name__ == "__main__":
    #import sys;sys.argv = ['', 'Test.testName']
    unittest.main()
