#!/usr/bin/python
# -*- coding: utf-8 -*-
import MySQLdb

"""
CREATE TABLE MyTable(
    'my_id' INT(10) unsigned NOT NULL,
    'my_name' TEXT CHARACTER SET utf8 NOT NULL,
    PRIMARY KEY(`my_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

Using this simplified python script I am trying to insert the string into a MySQL database and table:
"""
mystring = "Bientôt l'été"

myinsert = [ { "name" : mystring.encode("utf-8").strip()[:65535], "id" : 1 } ]

con = None
con = MySQLdb.connect('localhost', 'abc', 'def', 'ghi');
cur = con.cursor()

cur.execute("set names utf8;")     # <--- add this line,

sql = "INSERT INTO 'MyTable' ( 'my_id', 'my_name' ) VALUES ( %(id)s, %(name)s ) ; "
cur.executemany( sql, myinsert )
con.commit()
if con: con.close()
