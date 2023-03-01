from lxml import etree,sax
from io import StringIO, BytesIO
import sys
from functools import lru_cache
sys.setrecursionlimit(15000)

xml = open('Bigrock.xml', 'r').read()

root = etree.fromstring(xml)
t = etree.tostring(root)

#tree = etree.parse(StringIO(xml))
#t = etree.tostring(tree.getroot())
#print(t)

class CollectorTarget(object):
    def __init__(self):
        self.events = []
    def start(self, tag, attrib):
        self.events.append("start %s %r" % (tag, dict(attrib)))
    def end(self, tag):
        self.events.append("end %s" % tag)
    def data(self, data):
        pass
        #self.events.append("data %r" % data)
    def comment(self, text):
        self.events.append("comment %s" % text)
    def close(self):
        self.events.append("close")
        return "closed!"

parser = etree.XMLParser(target=CollectorTarget())
tree = etree.XML(xml, parser)  # doctest: +ELLIPSIS
if not len(parser.error_log):
    for event in parser.target.events:
        print(event)

from xml.dom.pulldom import SAX2DOM
handler = SAX2DOM()
s = sax.saxify(tree, handler)
dom = handler.document
# print(dom.firstChild.localName)

for x in tree.keys():
    for child in x.childNodes:
        print(child.localName)

@lru_cache(128)
def parse(x):
    for d in dom.childNodes:
        parse(dom.childNodes)
        print(d.localName)

for x in dom.childNodes:
    parse(x)

#tree = etree.parse("doc/test.xml")
#root = etree.fromstring(xml, base_url="http://where.it/is/from.xml")

xslt_root = etree.XML('''\
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <foo><xsl:value-of select="/a/b/text()" /></foo>
    </xsl:template>
</xsl:stylesheet>''')

transform = etree.XSLT(xslt_root)
f = StringIO('<a><b>Text</b></a>')
doc = etree.parse(f)
result_tree = transform(doc)
print(result_tree)