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
        try:
            scorefile = open("scores.json")
            self.scores = json.load(scorefile)
            scorefile.close()
        except:
            self.scores = []

    def newScore(self, name, score):
        self.scores.append((int(score), name))
	self.dumpScores()
        self.scores.sort(reverse=True)
        self.dumpScores()
        self.saveScores()
        self.saveHTML()

    def dumpScores(self):
        print json.dumps(self.scores)

    def saveScores(self):
        scorefile = open("scores.json", 'w')
        json.dump(self.scores, scorefile, indent=2)
        scorefile.close()

    def saveHTML(self):
        webfile = open("index.html", 'w')
        webfile.write("<html><head>")
        webfile.write("<title>TuxCannon Scores</title>")
        webfile.write("<meta http-equiv=\"refresh\" content=\"5\"></head>")
        webfile.write("<body")
        webfile.write("<center><h1>High Scores Board</h1></center>")
        for item in self.scores:
            webfile.write("<h3>")
            webfile.write(str(item[0]))
            webfile.write(" - ")
            webfile.write(str(item[1]))
            webfile.write("</h3>")
        webfile.write("</body></html>")
        webfile.close()

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
