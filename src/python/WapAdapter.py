'''
Created on Jul 12, 2016

@author: teemu
'''

import wap

SERVER = 'http://api.wolframalpha.com/v2/query.jsp'
APP_ID = 'TR9KLJ-J7L473XLGL'

engine = wap.WolframAlphaEngine(APP_ID, SERVER)


def makeQuery(text):
    queryStr = engine.CreateQuery(text)
    queryResult = engine.PerformQuery(queryStr)
    return wap.WolframAlphaQueryResult(queryResult)
