// =========================== variables =========================================
PImage bg, snare, hihat, bass, correct, cross, drumkit, party, startImg, back;
int mode;
int modeConstant;
float points;
int points_rounded;
color turquoise = #639FAB;
color light_blue = #1C5D99;
color grey = #BBCDE5;
color light_grey = #cfd9df;
color orange = #FF876D;
color green = #7EE081;
color red = #DF2935;
int el1 = 50;//Defining where in the y axis the ellipse 1 (for snare) will start
int el2 = 50; //Defining where in the y axis the ellipse 2 /for bass) will start
int el3 = 50; //Defining where in the y axis the ellipse 3 (for hi-hat) will start
int ySpeed = 8; //How fast/many pixels on the y axis the ellipse will move 
//int loopCount=0;
String username="";
int noteCount=0;
int highestScore=0;
 
  
int[] notesOk = {-1,-1,-1}; //making an array, -1 since they are not active in the beginning
int[] notesMissed = {-1,-1,-1};
int hsCount =0;
int hsLoop=0;

//Copied from airDrumProcessing
import processing.serial.*;
import oscP5.*;
import netP5.*;
XML xml;
OscP5 oscP5;
NetAddress myRemoteLocation;
String notes[];
String bnotes[];
String tempo[];
Serial myPort;  // Create object from Serial class
String val;
int instr;
int hiHat_hit = 51; //value = 3
int pedal_hit = 50; //value = 2
int snare_hit = 49; // value = 1

int notesTimer = 0;
int notesLineIndex = 0;
String notesLine;    
String notesBuzz;  
float finalscore ; //to calculate end score with percentage
int finalscore_rounded;

// =========================== setup =============================================
void setup(){
  size(700,700);
  bg = loadImage("background.jpg");
  bg.resize(700, 700);  
  mode = 0;
  
  //load Images
  drumkit = loadImage("drumkit.png");
  snare = loadImage("snare.png");
  hihat = loadImage("hihat.png");
  bass = loadImage("bass.png");
  correct = loadImage("correct.png");
  cross = loadImage("cross.png");
  party = loadImage("party.png");
  startImg = loadImage("start.png");
  back = loadImage("back.png");
  
  //Copied from airDrumProcessing
  String portName = Serial.list()[0];  //Rachit computer = 5, Emily = 0, Mila = 4
  myPort = new Serial(this, portName, 9600);

  oscP5 = new OscP5(this,1234);
  myRemoteLocation = new NetAddress("127.0.0.1",1234);
  sendMsgInt("/play",1);
}

void sendMsgInt(String addr, int v) {
  OscMessage myMessage = new OscMessage(addr);
  myMessage.add(v); 
  oscP5.send(myMessage, myRemoteLocation); 
}
// =========================== draw ==============================================
void draw(){
  //Mode 0: Intro
  if (mode == 0) { 
    introScreen(); 
     hsCount =0;
     hsLoop=0;
     noteCount=0;
  }
  // Mode 1-3: Play the game
  else if (mode == 1) {
    //easygame
    notes = loadStrings("notesE.txt");
    ySpeed= 6;
    readPort();
    game(85); 
    buzzers();
    notesHit();
    modeConstant =1;
  }
   else if (mode == 2) {
     //medium difficulty
    notes = loadStrings("notesM.txt");
    ySpeed=8;
    readPort();
    game(65); 
    buzzers();
    notesHit();
     modeConstant =2;
  }
   else if (mode == 3) {
     //difficult game
    notes = loadStrings("notesH.txt");
    ySpeed=10;
    readPort();
    game(50);
    buzzers();
    notesHit();
     modeConstant =3;
  }
  // Mode 4: Game over
  else if (mode == 4) {
    //end game
    gameOver();  
    
  }  
  // Mode 5: HighScore Board
  else if (mode == 5) {
    //end game
    if (hsLoop==0){
         highScoreBoard(); 
        hsLoop=1;
    }
    
  } 
  // Error
  else { 
    error(); 
  }
} 

// =========================== readPort ==============================================

void readPort(){
  if ( myPort.available() > 0) {  // If data is available
        instr = myPort.read();  
        println(instr);
      } 
      if (instr==hiHat_hit){
        //value = 3
        println("hiHat");
        sendMsgInt("/pedal",3);
      }
      else if (instr==pedal_hit){
        //value = 2
       println("Pedal");
       sendMsgInt("/hihat",1);
      }
      else if (instr==snare_hit){
       //value = 1
      println("Snare");
      sendMsgInt("/snare",2);
     }
}

// =========================== readNotes =================================================

 void readNotes(){
   int i = notesLineIndex;
   if(notesLineIndex < notes.length) {
     notesLineIndex++;
   } else return;
   
   notesLine= notes[i];    
   String[] list = split(notesLine, ',');
   
   if (Integer.parseInt(list[0]) == 1){el1 = 0; noteCount++;} else el1=0;
   if (Integer.parseInt(list[1]) == 1){el2 = 0; noteCount++;} else el2=0;
   if (Integer.parseInt(list[2]) == 1){el3 = 0; noteCount++;}else el3=0;
}


// =========================== error ===================================================

void error() {
  background(orange);
  fill(0);
  text("Error"+mode, 350, 350);
}

// =========================== buzzers ===================================================

void buzzers(){
    
int [] buzzers = {0,0,0};

  if ((el1 > 430) && (el1<520)) { //Defining the area where a hit would be successful
    buzzers[0] = 1;
  }
  
  if ((el2 > 430) && (el2<520)) { //Defining the area where a hit would be successful
     buzzers[1] = 1;
  }
  
  if ((el3 > 430) && (el3<520)) { //Defining the area where a hit would be successful
     buzzers[2] = 1;
   } 
  
    myPort.write('a'); //create a starting point for array
    myPort.write(buzzers[0]);
    myPort.write(buzzers[1]);
    myPort.write(buzzers[2]);
}

// =========================== notesHit ===================================================

void notesHit() { //with Piezo sensors
  if ((instr==snare_hit) && (el1 > 465) && (el1<560)) { //Defining the area where a hit would be successful
    points = points + 100;
    notesOk[0] = 20; //frames per second, how long the picture will stay
  } 
  else if ((instr==hiHat_hit) && (el2 > 465) && (el2<560)) {
    points = points + 100;
    notesOk[1] = 20;
  }
  else if ((instr==pedal_hit) && (el3 > 465) && (el3<560)) {
    points = points + 100;
    notesOk[2] = 20;
  }
  else {
      if ((instr==snare_hit) && ((el1 < 465) || (el1 > 560))) {
        notesMissed[0] = 20; //20 Frames per second, array item 0 (i=0)
      }
      if ((instr==hiHat_hit) && ((el2 < 465) || (el2 > 560))) {
        notesMissed[1] = 20; 
      }
      if ((instr==pedal_hit) && ((el3 < 465) || (el3 > 560))) {
        notesMissed[2] = 20; 
      }
  } 
}

// =========================== keyPressed ===================================================

void keyPressed() {
  //allow the game mode to change in the correct screen
  if (mode == 0){
       if (key=='1'){
        modeConstant =1;
        mode = 1; //easy mode        
      }else if( key=='2'){
        modeConstant =2;
        mode = 2; //medium mode         
      }else if (key=='3'){
        modeConstant =3;
        mode = 3; }//difficult mode         
  }
  
  if (mode == 4){
    if (key==ENTER || key==RETURN){
      highscore(points_rounded);
      mode= 5; //switching to highScoreBoard
      println(mode);
    }else{ 
      if (key!=BACKSPACE){
        if (username==null || username.length()<5){
        username +=key;
      }
      }
    }
  }
  
   if (mode == 5){
     println(mode);
    if (key==BACKSPACE){
    mode= 0; //switching to Intro
    }
  }
  //game
  if (mode==1 || mode==2 || mode==3){
    username="";
    if (key==BACKSPACE){
      mode= 4; //switching to gameover
    }
    
     if ((keyCode == LEFT) && (el1 > 465) && (el1<560)) { //Defining the area where a key press would be successful
        points = points + 100;
        notesOk[0] = 20; //frames per second, how long the picture will stay
      } 
      else if ((keyCode == UP) && (el2 > 465) && (el2<560)) {
        points = points + 100;
        notesOk[1] = 20;
      }
      else if ((keyCode == RIGHT) && (el3 > 465) && (el3<560)) {
        points = points + 100;
        notesOk[2] = 20;
      }
      else {
          if ((keyCode == LEFT) && ((el1 < 465) || (el1 > 560))) {
            notesMissed[0] = 20; //20 Frames per second, array item 0 (i=0)
          }
          if ((keyCode == UP) && ((el2 < 465) || (el2 > 560))) {
            notesMissed[1] = 20; 
          }
          if ((keyCode == RIGHT) && ((el3 < 465) || (el3 > 560))) {
            notesMissed[2] = 20; 
          }
      } 
  }
}
    
