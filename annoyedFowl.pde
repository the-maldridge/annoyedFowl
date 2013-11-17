int numAttempts = 0;
boolean started = false;
PImage bg;
splash sp;
cannon tux;
ArrayList<projectile> disc;
 
void setup() {
  size(800, 400);
  numAttempts = 0;
  bg = loadImage("glyphs/backdrop.png");
  sp = new splash("glyphs/splashscreen.png");
  tux = new cannon("glyphs/tux.png");
  folder = new target("glyphs/folder.png");
  disc = new ArrayList<projectile>();
}

void draw() {
  if (started) {
    background(bg);
    tux.update();
    for(int i=0; i<disc.size(); i++) {
      disc.get(i).update();
    }
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
