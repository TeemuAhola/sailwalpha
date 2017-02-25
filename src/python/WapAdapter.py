'''
Created on Jul 12, 2016

@author: teemu
'''

import wap
import pickle

SERVER = 'http://api.wolframalpha.com/v2/query.jsp'
APP_ID = 'TR9KLJ-J7L473XLGL'

try:
    import pyotherside
except ImportError:
    import sys
    # Allow testing Python backend alone.
    print("PyOtherSide not found, continuing anyway!")
    class pyotherside:
        def atexit(self, *args): pass
        def send(self, *args):
            print("printout:", [str(a) for a in args])
    sys.modules["pyotherside"] = pyotherside()

def debug(*text):
    pyotherside.send('log-d', 'python: ' + ' '.join([str(s) for s in text]))

def info(*text):
    pyotherside.send('log-i', 'python: ' + ' '.join([str(s) for s in text]))

def error(*text):
    pyotherside.send('log-e', 'python: ' + ' '.join([str(s) for s in text]))
    

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
        return "img %s:%s:%s:%s:%s;" % (self.alt, self.src, self.title, self.width, self.height)

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
        return "subpod %s:%s:%s:%s;" % (self.title, self.plaintext, self.img, self.mathml)

class Pod(object):
    
    def __init__(self, pod):
        p = wap.Pod(pod)
        self.__title = p.Title()[0]
        self.__subpods = map(SubPod, p.Subpods())

    @property
    def title(self):
        return self.__title
    
    @property
    def subpods(self):
        return self.__subpods
    
    def __str__(self):
        return "pod %s:%s" % (self.__title, list(map(str, self.subpods)))

class AssumptionValue(object):
    
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
        return "assumptionValue %s:%s:%s;" % (self.name, self.input, self.desc)

class Assumptions(object):
    
    def __init__(self, assumption):
        a = wap.Assumption(assumption)
        self.__type = a.Type()
        self.__count = a.Count()
        self.__word = a.Word()
        self.__values = map(AssumptionValue, a.Value())
    
    @property
    def type(self):
        return self.__type

    @property
    def count(self):
        return self.__count

    @property
    def word(self):
        return self.__word

    @property
    def values(self):
        return self.__values
    
    def __str__(self):
        return "assumption %s:%s:%s:%s;" % (self.type, self.count, self.word, list(map(str, self.values)))

class Query(object):
    
    WIDTH = 600
    MAX_WIDTH = 700
    
    @classmethod
    def SimpleQuery(cls, query):
        return cls(query)
    
    @classmethod
    def AssumptionQuery(cls, query, assumption):
        return cls(query, assumption=assumption)

    @classmethod
    def StateQuery(cls, query, state):
        return cls(query, state=state)
    
    def __init__(self, query, assumption=None, state=None):
        engine = wap.WolframAlphaEngine(APP_ID, SERVER)
        engine.Width = Query.WIDTH
        engine.MaxWidth = Query.MAX_WIDTH
        queryObj = engine.CreateQuery(query)
        if assumption: queryObj.AddAssumption(assumption.input)
        if state: queryObj.AddPodState(state)
        queryResult = engine.PerformQuery(queryObj)
        self.__result = wap.WolframAlphaQueryResult(queryResult)

    @property
    def isSuccess(self):
        return self.__result.IsSuccess() if self.__result else False
    
    @property
    def pods(self):
        return map(Pod, self.__result.Pods())
    
    @property
    def assumptions(self):
        return map(Assumptions, self.__result.Assumptions())


def makeSimpleQuery(query):
    return Query.SimpleQuery(query)

def saveQuery(query, path):
    
    with open(path, "wb") as fp:
        pickle.dump(query, fp)
        
def loadQuery(path):
    with open(path, "rb") as fp:
        return pickle.load(fp)

def getAttribute(obj, *args):
    for name in args:
        obj = getattr(obj, name)
    
    return obj
