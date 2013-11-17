int numAttempts = 0;
int hits = 0;
boolean started = false;
PImage bg;
splash sp;
cannon tux;
target folder;
ArrayList<projectile> disc;
 
void setup() {
  size(800, 400);
  numAttempts = 0;
  bg = loadImage("glyphs/backdrop.png");
  sp = new splash("glyphs/splashscreen.png");
  tux = new cannon("glyphs/tux.png");
  disc = new ArrayList<projectile>();
  folder = new target();
  folder.create();
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
        folder.create();        
      }
    }
    println("hits: " + str(hits));
  } else {
    sp.drawSplash();
  }
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
      disc.add(tux.fire());
      numAttempts++;
      break;
    case '\n':
      started=true;
      break;
    default: 
      println("that was not a valid key");
  }
}
