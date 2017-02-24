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

class Image(object):
    
    def __init__(self, img):
        self.__alt = img['alt']
        self.__src = img['src']
        self.__title = img['title']
        self.__width = img['width']
        self.__height = img['height']

    @property
    def alt(self):
        return self.__alt

    @property
    def src(self):
        return self.__src

    @property
    def title(self):
        return self.__title

    @property
    def width(self):
        return self.__width

    @property
    def height(self):
        return self.__height
    
    def __str__(self):
        return "img:%s:%s:%s:%s:%s" % (self.alt, self.src, self.title, self.width, self.height)

class SubPod(object):
    
    def __init__(self, subpod):
        sp = wap.Subpod(subpod)
        self.__title = sp.Title()[0]
        self.__plaintext = sp.Plaintext()[0] if sp.Plaintext() and not isinstance(sp.Plaintext()[0], list) else ''
        self.__img = Image(dict(sp.Img()[0]))
        self.__mathml = sp.MathML()[0] if sp.MathML() else ''

    @property
    def title(self):
        return self.__title

    @property
    def plaintext(self):
        return self.__plaintext

    @property
    def img(self):
        return self.__img

    @property
    def mathml(self):
        return self.__mathml

    def __str__(self):
        return "subpod %s:%s:%s:%s" % (self.title, self.plaintext, self.img, self.mathml)

class Pod(object):
    
    def __init__(self, pod):
        p = wap.Pod(pod)
        self.__title = p.Title()[0]
        self.__subpods = map(SubPod, p.Subpods())

    @property
    def title(self):
        return self.__title
    
    @property
    def subPods(self):
        return self.__subpods
    
    def __str__(self):
        return "pod %s:%s" % (self.__title, list(map(str, self.__subpods)))

class Assumption(object):
    
    def __init__(self, value):
        self.__value = dict(value)
        
    @property
    def name(self):
        return self.__value['name']

    @property
    def input(self):
        return self.__value['input']

    @property
    def desc(self):
        return self.__value['desc']
    
    def __str__(self):
        return "assumption %s:%s:%s" % (self.name, self.input, self.desc)

class Assumptions(object):
    
    def __init__(self, assumption):
        a = wap.Assumption(assumption)
        self.__type = a.Type()
        self.__count = a.Count()
        self.__word = a.Word()
        self.__assumptions = map(Assumption, a.Value())
        
    def __str__(self):
        return "assumption %s:%s:%s:%s" % (self.__type, self.__count, self.__word, list(map(str, self.__assumptions)))

class Query(object):
    
    def __init__(self, query):
        self.__result = makeQuery(query)
        
    def getPods(self):
        return map(Pod, self.__result.Pods())
    
    def getAssumptions(self):
        return map(Assumptions, self.__result.Assumptions())

