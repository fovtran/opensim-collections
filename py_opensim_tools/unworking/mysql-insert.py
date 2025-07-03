#!/usr/bin/python
# -*- coding: utf-8 -*-
import MySQLdb

"""
CREATE TABLE MyTable(
    'my_id' INT(10) unsigned NOT NULL,
    'my_name' TEXT CHARACTER SET utf8 NOT NULL,
    PRIMARY KEY(`my_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
"""
mystring = "Bientôt l'été"
myinsert = [ { "name" : mystring.encode("utf-8").strip()[:65535], "id" : 1 } ]

def insert():
    con = None
    con = MySQLdb.connect('localhost', 'abc', 'def', 'ghi');
    cur = con.cursor()
    cur.execute("set names utf8;")     # <--- add this line,
    sql = "INSERT INTO 'MyTable' ( 'my_id', 'my_name' ) VALUES ( %(id)s, %(name)s ) ; "
    cur.executemany( sql, myinsert )
    con.commit()
    if con: con.close()

def query():
    con = None
    try:
        con = MySQLdb.connect('localhost', 'diego2', 'diego2', 'opensim');
    except(MySQLdb.OperationalError):
        print("MySQLdb.OperationalError")
        exit(-2)
    cur = con.cursor()
    cur.execute("set names utf8;")     # <--- add this line,
    sql = "SELECT * from useraccounts; "
    cur.execute( sql )
    con.commit()
    if con: con.close()

query()