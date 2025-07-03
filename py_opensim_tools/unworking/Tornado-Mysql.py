import config
import os.path
import re
import MySQLdb
import tornado.ioloop
import tornado.web

class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.render("question3.html")

class StopTornado(tornado.web.RequestHandler):
    def get(self):
        tornado.ioloop.IOLoop.instance().stop()

class ReturnQuery(tornado.web.RequestHandler):
    def post(self):
        connection = MySQLdb.connect(**config.mysql_config)
        cursor = connection.cursor()
        if 'lowermass' in self.request.arguments and 'uppermass' in self.request.arguments:
            lowermass = self.get_argument('lowermass')
            uppermass = self.get_argument('uppermass')
            # Testing for bad input and should block Injection attacks
            # Since you can't really do an injection attack with only numbers
            # Placing any non-int input will throw an exception and kick you to the      Error.html page
            try:
                lowermass = int(lowermass)
                uppermass = int(uppermass)
            except ValueError:
                self.render("Error.html")
            if lowermass < uppermass:

                cursor.execute ('''SET @row_num=0;''')
                cursor.execute('''SELECT @row_num:=@row_num+1 as 'Num', b.commonname
                                FROM Bird b
                                JOIN Bodymass m ON b.EOLid = m.EOLid
                                WHERE m.mass BETWEEN %s AND %s
                                GROUP BY b.commonname''',(lowermass, uppermass))

                birds = cursor.fetchall()
                self.render("question2.html", birds = birds)
            else:
                self.render("Error.html")

        else :
            self.render("Error.html")

class Application(tornado.web.Application):
    def __init__(self):
        handlers = [
            (r"/", MainHandler),
            # Add more paths here
            (r"/KillTornado/", StopTornado),
            (r"/tables/", ReturnQuery),
            (r"/tables/localhost8888", MainHandler)
        ]
        settings = {
            "debug": True,
            "template_path": os.path.join(config.base_dir, "templates"),
            "static_path": os.path.join(config.base_dir, "static")
        }
        tornado.web.Application.__init__(self, handlers, **settings)

if __name__ == "__main__":
    app = Application()
    app.listen(config.port)
    print "Starting tornado server on port %d" % (config.port)
    tornado.ioloop.IOLoop.instance().start()
