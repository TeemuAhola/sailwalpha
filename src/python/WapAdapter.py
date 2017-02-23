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

def getSubPodData(subpod):
    return {'title':subpod.Title()[0],
            'plaintext':subpod.Plaintext()[0] if subpod.Plaintext() and not isinstance(subpod.Plaintext()[0], list) else '',
            'img':dict(subpod.Img()[0]) if subpod.Img() else '',
            'mathml':subpod.MathML()[0] if subpod.MathML() else ''}

def getSubPods(pod):
    spods = []
    for subpod in pod.Subpods():
        sp = wap.Subpod(subpod)
        print("subpod: ", str(sp))
        spods.append(getSubPodData(sp))

    return spods

def getPods(result):
    pods = []
    for pod in result.Pods():
        p = wap.Pod(pod)
        sp = getSubPods(p)
        pods.append({'title':p.Title()[0], 'subpods':sp})

    return pods
