import java.awt.event.WindowEvent;
import java.awt.event.WindowAdapter;
import ddf.minim.*;
import javax.swing.JFrame;
import java.util.*;
import processing.net.*;


Client myClient;


int numAttempts;
int hits;
int score;
boolean started = false;
PImage bg;
splash sp;
cannon tux;
target folder;
HUD trycount;
ArrayList<projectile> disc;
int goal;  //Number of hits until you win
String[] scores = {"","","","","",""};
int[] scoreList = {-1,-1,-1,-1,-1,-1};
boolean gameover;
PFrame f;


//Define sound variables
Minim minim;
Sound startup;
Sound criticalStop;
Sound shutdown;
  
void setup() {
  size(800, 400);
  minim = new Minim(this);
  bg = loadImage("glyphs/backdrop.png");
  sp = new splash("glyphs/splashscreen.png");
  tux = new cannon("glyphs/tux.png");
  trycount = new HUD();
  disc = new ArrayList<projectile>();
  folder = new target();
  folder.create();
  numAttempts = 0;
  hits = 0;
  goal = 5;
  
  
  //setupClient
  myClient = new Client(this, "minecraft.michaelwashere.tk", 32001);
  
  
  //Initialize sound objects
  startup = new Sound("audio/Windows XP Startup.wav");
  criticalStop = new Sound("audio/Windows XP Critical Stop.wav");
  shutdown = new Sound("audio/Windows XP Shutdown.wav");
  
  gameover = false;
}

void draw() {
  if (started) {
    background(bg);
    tux.update();
    folder.update();
    for(int i=0; i<disc.size(); i++) {
      disc.get(i).update(folder);
    }
    for(int i=0; i<disc.size(); i++) {
      if (disc.get(i).hit() && !(disc.get(i).checked())) {
        disc.get(i).check();
        hits = hits + 1;
        criticalStop.play();  //play critical stop when player hits target
        folder.create();        
      }
    }
    score = int(float(hits)/numAttempts*10);
    trycount.update(hits, numAttempts);
  } 
  else {
    //sp.drawSplash();
    background(sp.sp);
  }

if(hits >= 5){
    f = new PFrame(score, scores, scoreList);
    f.addWindowListener(new WindowAdapter(){
      public void windowClosing(WindowEvent e){
        scores = f.getScores();
        scoreList = f.getScoreList();
        String yourScore = f.getyourScore();
        
        
        postToServer(yourScore);
        //updateClient();
        
        
        QFrame q = new QFrame(scores);
        q.addWindowListener(new WindowAdapter(){
         public void windowClosing(WindowEvent e){
           reset();
         }
       });
      }
    });
    shutdown.playWithoutRewind();
    noLoop();
}
 
}

void updateClient(){
  String stuffToGet = "";
  stuffToGet = myClient.readString();
  scores = stuffToGet.split(":");
}

void postToServer(String yourScore){
  myClient.write(yourScore);
}

void reset() {
     started = false;
        numAttempts = 0;
        hits = 0;
        startup.rewind();
        shutdown.rewind();
        criticalStop.rewind();
        folder.create();
    loop();
}

void keyPressed() {
  switch(key) {
    case 'd':
      tux.lowerCannon();
      break;
    case 'a':
      tux.raiseCannon();
      break;
    case 'w':
      tux.incPower();
      break;
    case 's':
      tux.decPower();
      break;
    case ' ':
    if(gameover == false)
    {
      disc.add(tux.fire());
      numAttempts++;
    }
      break;
    case '\n':
      started=true;
      startup.play();  //Play startup after splash screen
      break;
    default: 
      println("that was not a valid key");
  }
}

void stop()
{
  //Called when processing is closing
  startup.stop();
  criticalStop.stop();
  shutdown.stop();
  minim.stop();
  super.stop();
}
