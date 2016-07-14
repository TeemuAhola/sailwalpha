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
    print(queryStr)
    queryResult = engine.PerformQuery(queryStr)
    print(queryResult)
    return wap.WolframAlphaQueryResult(queryResult)

def isQueryOk(query):
    return query.IsSuccess()

def getPods(result):
    pods = []
    for pod in result.Pods():
        pods.append(wap.Pod(pod))

    return pods

def getPodData(pod):
    print("from pythoin", pod)
    return {'title':pod.Title()[0]}

def getSubPods(pod):
    spods = []
    for subpod in pod.Subpods():
        print(subpod)
        spods.append(wap.Subpod(subpod))

    return spods

def getSubPodData(subpod):
    return {'title':subpod.Title()[0],
            'plaintext':subpod.Plaintext()[0] if subpod.Plaintext() and not isinstance(subpod.Plaintext()[0], list) else '',
            'img':dict(subpod.Img()[0]) if subpod.Img() else '',
            'mathml':subpod.MathML()[0] if subpod.MathML() else ''}
