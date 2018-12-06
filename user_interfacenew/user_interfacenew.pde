// =========================== variables =========================================
PImage bg, snare, hihat, bass, correct, cross, drumkit, party;
int mode, points;
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

int[] notesOk = {-1,-1,-1}; //making an array, -1 since they are not active in the beginning
int[] notesMissed = {-1,-1,-1};

//Copied from airDrumProcessing
import processing.serial.*;
import oscP5.*;
import netP5.*;
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
  
  //Copied from airDrumProcessing
  String portName = Serial.list()[4];  //Rachit computer = 5, Emily = 0, Mila = 4
  myPort = new Serial(this, portName, 9600);
  notes = loadStrings("notes.txt");
  tempo = loadStrings("tempo.txt");
  bnotes = loadStrings("bnotes.txt");
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
  }
  // Mode 1: Play the game
  else if (mode == 1) {
    readPort();
    game(); 
    notesHit();
  }
  // Mode 2: Game over
  else if (mode == 2) {
    gameOver();    
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
   }
   else return;
   notesLine= notes[i];    
   String[] list = split(notesLine, ',');
   
   if (Integer.parseInt(list[0]) == 1) el1 = 0;
   if (Integer.parseInt(list[1]) == 1) el2 = 0;
   if (Integer.parseInt(list[2]) == 1) el3 = 0;
   
   notesBuzz= bnotes[i];    
   String[] blist = split(notesBuzz, ',');
   myPort.write('a'); //create a starting point for array
   myPort.write(blist[0]);
   myPort.write(blist[1]);
   myPort.write(blist[2]);
}

// =========================== error ===================================================

void error() {
  background(orange);
  fill(0);
  text("Error"+mode, 350, 350);
}

// =========================== mouseReleased ===================================================
  
void mouseReleased() {
  if (mode == 0) {
    mode = 1; // switching to game
  } 
  else if (mode == 1) {
    mode = 2; //switching to gameOver
  }
  else if (mode == 2) {
    mode = 0; //switching to intro
  }
  else {
    mode = 0; //switching to intro
  }
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
    
    
    
