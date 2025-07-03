from lxml import etree,sax,objectify
from io import StringIO, BytesIO
import sys
from functools import lru_cache
sys.setrecursionlimit(15000)

class CollectorTarget(object):
    def __init__(self):
        self.events = []
        self.level = 0
    def start(self, tag, attrib):
        self.level+=1
        self.events.append("start %s %r" % (tag, dict(attrib)))
    def end(self, tag):
        self.level-=1
        self.events.append("end %s" % tag)
    def data(self, data):
        pass
        #self.events.append("data %r" % data)
    def comment(self, text):
        self.events.append("comment %s" % text)
    def close(self):
        self.events.append("close")
        return "closed!"


xml = open('Bigrock.xml', 'r').read()
sxml = StringIO(xml)
parser = etree.XMLParser(target=CollectorTarget())
tree = etree.XML(xml, parser)  # doctest: +ELLIPSIS
if not len(parser.error_log):
    for event in parser.target.events:
        print(event)

root = objectify.fromstring(xml)
print(objectify.dump(root))
print(root.keys())

objectify.xsiannotate(root)
print(objectify.dump(root))
schemified = etree.tostring(root, pretty_print=True)
print(schemified)
xslt_root = etree.XML(''' ''')
transform = etree.XSLT(xslt_root)
#result = transform(doc)
#result.write_output("output.txt.gz", compression=9)    # doctest: +SKIP

#print(root.some.child["{http://other/}unknown"].text)
#path.setattr(root, "my value") # creates children as necessary
#path.hasattr(root)
#path.addattr(root, "my new value")

#schema = etree.XMLSchema(file=xml)
schema = etree.XMLSchema(file=schemified)
parser = objectify.makeparser(schema = schema)
print(schema)
