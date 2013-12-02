import SocketServer
import json
import time
import operator

class MyTCPHandler(SocketServer.BaseRequestHandler):
    def handle(self):
        self.data = self.request.recv(1024).strip()
        self.parseData(self.data)

    def parseData(self, data):
        print data.split("-")[0]
        print data.split("-")[1]
        db.newScore(data.split("-")[0], data.split("-")[1])

class scoreTable():
    def __init__(self):
        self.scores = [] #at some point load the database from file

    def newScore(self, name, score):
        self.scores.append((int(score), name))
	self.dumpScores()
        self.scores.sort()
        self.dumpScores()

    def dumpScores(self):
        print json.dumps(self.scores)

if __name__ == "__main__":
    HOST, PORT = "localhost", 32001

    while True:
        try:
            time.sleep(1)
            server = SocketServer.TCPServer((HOST, PORT), MyTCPHandler)
            break
        except:
            print "couldn't start server, retrying"

    print "server instantiated".center(80, "=")
    db = scoreTable()

    # Activate the server; this will keep running until you
    # interrupt the program with Ctrl-C
    server.serve_forever()
