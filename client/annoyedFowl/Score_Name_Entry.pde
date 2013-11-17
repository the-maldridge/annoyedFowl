
import javax.swing.JFrame;
import processing.net.*;

class Score_Name_Entry{
  PFrame f;
  
  Score_Name_Entry( int score){
    f = new PFrame(score);
  }  
}  
  
  public class secondApplet extends PApplet{
    int buttonX, buttonY, buttonH, buttonW; 
    int buttonSize;
    boolean button;
    String input;
    String name;
    int score;
    Client myClient;
    
    secondApplet(int s){
     score = s; 
    }
    void setup(){
      size(800,400);
      button = false;
      buttonH = 75;
      buttonW = 150;
      buttonX = width/2 - buttonW/2;
      buttonY = height*7/8 - buttonH;
      name = "";
      input = "";
      myClient = new Client(this, "localhost", 9600);
    } 
    
    
    
    
    void draw(){
       update(mouseX, mouseY);
       background(255);
       
       if(button){
         fill(200);
       }else{
        fill(255); 
       }
       stroke(0);
       rect(buttonX, buttonY, buttonW, buttonH);
       
       textSize(32);
       stroke(0);
       fill(0);
       textAlign(CENTER, BOTTOM);
       text("Submit", width/2, height*7/8);
       
       textSize(40);
       stroke(0);
       fill(0);
       textAlign(CENTER,CENTER);
       text(input, width/2, height/2);
       
       textSize(40);
       stroke(0);
       fill(0);
       textAlign(CENTER, TOP);
       text("Please enter your initials", width/2, height/8);
     }
     
     
     
     void update(int x, int y){
       if(overButton(buttonX, buttonY, buttonW, buttonH)){
         button = true;
       }else{
        button = false; 
       }
     }
     
     
  void mousePressed(){
    if(button){
      postScore(name.toCharArray(), score);
    }
  }
  void keyPressed() {
  if (key == '\n' ) {
    name = input;
  }else if (key == BACKSPACE){
    if(input.length() > 0){
      input = input.substring(0, input.length() - 1);
    }
  }else {
    String check = key + "";
    if(input.length() <= 2 && check.matches("[a-zA-Z_0-9]")){
      input = input + key; 
    }
  }
}
  
  
  
   boolean overButton(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
   }
   
   
   public void postScore(char[] name, int score){
     myClient.write(score);
     for(int i = 0; i < name.length; i++){
       myClient.write(name[i]);
     }
     getResult();
   }
   public void getResult(){
     String scores = myClient.readString();
     println("SCORE RETURN: " + scores);
     showResult(scores);
   }
   public void showResult(String scs){
     QFrame q = new QFrame(scs);
   }
   
   
 }
  
  public class PFrame extends JFrame {
    secondApplet s;
  public PFrame(int score){
    setBounds(0, 0, 810, 410);
    s = new secondApplet(score);
    add(s);
    s.init();
    show();
  }
}

  public class QFrame extends JFrame {
    thirdApplet t;
  public QFrame(String scores){
    setBounds(0, 0, 810, 410);
    t = new thirdApplet(scores);
    add(t);
    t.init();
    show();
  }
}
  
  
public class thirdApplet extends PApplet{
  String display;
  thirdApplet(String scores){
    display = scores;
  }
  void setup(){
    size(400,800);
  }
  void draw(){
    textAlign(CENTER,CENTER);
    text(display,width/2, height/2);
  }
}
