import ddf.minim.*;
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
boolean gameover;

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
  hits = 0;
  goal = 5;

  
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
    score = int(float(hits)/numAttempts);
    trycount.update(hits, numAttempts);
  } 
  else {
    //sp.drawSplash();
    background(sp.sp);
  }
  //If the player has hit 5 targets, the shutdown music will play
  if(hits == goal)
  {
    shutdown.playWithoutRewind();
    gameover = true;
  }
}

void reset() {
    numAttempts = 1;
    hits = 1;
    started = false;
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
    case 'r':
      if(gameover == true)
      {
        started = false;
        numAttempts = 0;
        hits = 1;
        startup.rewind();
        shutdown.rewind();
        criticalStop.rewind();
        folder.create();
        gameover = false;
        //background(sp.sp);
      }
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
