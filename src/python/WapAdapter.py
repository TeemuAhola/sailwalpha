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

def isQueryOk(query):
    return query.IsSuccess()

def getPods(result):
    pods = []
    for pod in result.Pods():
        pods.append(wap.Pod(pod))

    return pods

def getPodData(pod):
    return {'title':pod.Title()}

def getSubPods(pod):
    spods = []
    for subpod in pod.Subpods():
        spods.append(wap.Subpod(subpod))

    return spods

def getSubPodData(subpod):
    return {'title':subpod.Title(),
            'plaintext':subpod.Plaintext(),
            'img':subpod.Img()}
