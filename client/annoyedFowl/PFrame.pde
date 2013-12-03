 import java.awt.*;
  public class PFrame extends JFrame {
    secondApplet s;
  public PFrame(int score,String[] scores,int[] scoreList){
    setBounds(0, 0, 810, 410);
    s = new secondApplet(score, scores,  scoreList);
    add(s);
    s.init();
    show();
  }
  String[] getScores(){
   return s.getScores(); 
  }
  int[] getScoreList(){
    return s.getScoreList();
  }
  String getyourScore(){
   return s.getyourScore(); 
  }
  public void closeWindow(){
    WindowEvent c = new WindowEvent(this, WindowEvent.WINDOW_CLOSING);
    Toolkit.getDefaultToolkit().getSystemEventQueue().postEvent(c);
  }
  
  
   public class secondApplet extends PApplet{
    int buttonX, buttonY, buttonH, buttonW; 
    int buttonSize;
    boolean button, balls;
    String input;
    String name;
    String yourScore;
    int score;
    String[] sc;
    int[] sL;

    
    secondApplet(int s, String[] scores,int[] scoreList){
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
      yourScore = "";
      sc = scores;
      sL = scoreList;

    } 
    
    
    String[]  getScores(){
     return sc; 
    }
    int[] getScoreList(){
      return scoreList;
    }
    String getyourScore(){
     return yourScore; 
    }
    
    void draw(){
       update(mouseX, mouseY);
       background(255);
       
       if(button && !balls){
         fill(200);
       }else if (button && balls){
        fill(255, 0, 0); 
        balls = false;
       }else{
        fill(255);
       }
       stroke(0);
       rect(buttonX, buttonY, buttonW, buttonH);
       
       textSize(40);
       stroke(0);
       fill(0);
       textAlign(CENTER, CENTER);
       text("Submit", width/2, height*7/8 - 30);
       
       textSize(40);
       stroke(0);
       fill(0);
       textAlign(CENTER,CENTER);
       text(input, width/2, height/2);
       
       textSize(40);
       stroke(0);
       fill(0);
       textAlign(CENTER, CENTER);
       text("Your Score: " + score, width/2, height/8);
       
       textSize(40);
       stroke(0);
       fill(0);
       textAlign(CENTER, CENTER);
       text("Please enter your initials", width/2, height*2/8);
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
      if(input.length()>0){
        name = input;
        postScore(name, score);
      }else{
        balls = true;
      }
    }

  }
  void keyPressed() {
  if (key == BACKSPACE){
    if(input.length() > 0){
      input = input.substring(0, input.length() - 1);
    }
  }else {
    String check = key + "";
    if(check.matches("[a-zA-Z_0-9]")){
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
   
   
   public void postScore(String name, int score){
     String thing = name + "-" + score;
     yourScore = thing;
     scores[0] = thing;
     scoreList[0] = score;
     //println(Arrays.toString(scores));
     //println(Arrays.toString(scoreList));
     for(int i = 0; i < scoreList.length; i++){
       for (int j = scoreList.length - 1; j > i; j--){
         if(scoreList[j] < scoreList[j-1]){
           int temp = scoreList[j];
           scoreList[j] = scoreList[j-1];
           scoreList[j-1] = temp;
           String tempS = scores[j];
           scores[j] = scores[j-1];
           scores[j-1] = tempS;
         }
       }
     }
     //println(Arrays.toString(scores));
     //println(Arrays.toString(scoreList));
     showResult();
   }
   public void showResult(){
     closeWindow();
   }
   
   
 }
}
