// =========================== variables =========================================
PImage bg, snare, hihat, bass, correct, cross;
int mode, points, lives;
color turquoise = #639FAB;
color light_blue = #1C5D99;
color grey = #BBCDE5;
color light_grey = #cfd9df;
color orange = #FF876D;
color green = #7EE081;
color red = #DF2935;
int el1 = 50;//Defining where in the y axis the ellipse 1 will start
int el2 = 50; //Defining where in the y axis the ellipse 2 will start
int el3 = 50; //Defining where in the y axis the ellipse 3 will start
int ySpeedMed = 2; //How fast/many pixels on the y axis the ellipse will move 
int ySpeedSlow = 3; 
int ySpeedFast = 4; 

int[] notesOk = {-1,-1,-1};
int[] notesMissed = {-1,-1,-1};

//Copied from airDrumProcessing
import processing.serial.*;
String notes[];
String tempo[];
Serial myPort;  // Create object from Serial class
String val;
int instr;
int hiHat_hit = 51; //value = 3
int pedal_hit = 50; //value = 2
int snare_hit = 49; // value = 1

// =========================== setup =============================================
void setup(){
  size(700,700);
  bg = loadImage("background.jpg");
  bg.resize(700, 700);  
  mode = 0;

  snare = loadImage("snare.png");
  hihat = loadImage("hihat.png");
  bass = loadImage("bass.png");
  correct = loadImage("correct.png");
  cross = loadImage("cross.png");
  //Copied from airDrumProcessing
  String portName = Serial.list()[0]; 
  myPort = new Serial(this, portName, 9600);
   notes = loadStrings("data/notes.txt");
   tempo = loadStrings("data/tempo.txt");
}

// =========================== draw ==============================================
void draw(){
  
  //Mode 0: Intro
  if (mode == 0) { 
    introScreen(); 
  }
  // Mode 1: Play the game
  else if (mode == 1) {
    game(); 
    
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

// =========================== introScreen ==============================================

void introScreen() {
  background(light_grey);
  fill(255);
  textSize(50);
  text("Start game", 230, 350);
  points = 0;
  lives = 5;
}

// ============================= game =====================================================

void game() {
  
  if ( myPort.available() > 0) {  // If data is available,
        instr = myPort.read();    
      } 
      
      if (instr==hiHat_hit){
        //value = 3
         println("hiHat"); 
       }
         
      else if (instr==pedal_hit){
        //value = 2
       println("Pedal");
       }
       
       else if (instr==snare_hit){
       //value = 1
       println("Snare");
       }

   if (keyPressed == true) {                           
     if (key == '1') {
        println("Start");   
        readNotes();
    } 
  }
   
  background(bg);
  
  text("Score: "+points, 570, 60); // Score of player
  text("Lives: "+lives, 570, 75); // Lives of player
  textSize(18);
   
  fill(turquoise);  
  noStroke();
  ellipse(200, el1, 50, 50); // Ellipse for snare
  el1 = el1 + ySpeedSlow;
    if(el1 > height) {
      el1 = 50;
    }
  fill(light_blue);
  ellipse(350, el2, 50, 50); // Ellipse for hi-hat
  el2 = el2 + ySpeedFast;
    if(el2 > height) {
        el2 = 50;
    }
  fill(grey);
  ellipse(500,el3, 50, 50); // Ellipse for bass
  el3 = el3 + ySpeedMed;
    if(el3 > height) {
        el3 = 50;
    }
  
  stroke (green);
  strokeWeight (8);
  line(0,515,700,515);
  
  image(snare, 160, 570, 80, 80);
  image(hihat, 310, 550, 80, 120);
  image(bass, 460, 575, 80, 85);
  
  if (lives == 0) {
      mode = 2;
  } 
  
  for(int i=0; i<3; i++) {  //an array for images
   if(notesOk[i] > 0) {
       if(i==0) image(correct, 200, 570, 80, 80); 
       if(i==1) image(correct, 350, 570, 80, 80); 
       if(i==2) image(correct, 500, 570, 80, 80); 
       notesOk[i]--;
       if(notesOk[i] == 0) notesOk[i] = -1;
    }
  }
  
  for(int i=0; i<3; i++) {
   if(notesMissed[i] > 0) {
       if(i==0) image(cross, 200, 570, 80, 80); 
       if(i==1) image(cross, 350, 570, 80, 80); 
       if(i==2) image(cross, 500, 570, 80, 80); 
       notesMissed[i]--;
       if(notesMissed[i] == 0) notesMissed[i] = -1;
    }
  }
}
// =========================== readNotes =================================================

 void readNotes(){
   for (int i = 0 ; i < notes.length; i++) {
     String notesLine= notes[i];    
     String[] list = split(notesLine, ',');
     println(notesLine);
     myPort.write('a');
     myPort.write(list[0]);
     myPort.write(list[1]);
     myPort.write(list[2]);
     delay(10000);
   }
}

// =========================== gameOver =================================================

void gameOver() {
  background(bg);
  fill(255);
  textSize(50);
  text("Game Over!", 150, 250);
  text("Your Highscore:"+points, 150, 350);
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
  else if (mode == 2) {
    mode = 0; //switching to intro
  }
  else {
    mode = 0; //switching to intro
  }
}
// =========================== keyPressed ===================================================

void keyPressed() {
  if (((keyCode == LEFT)||(instr==snare_hit)) && (el1 > 465) && (el1<560)) { //Left arrow key pressed and hit the ellipse at the white line
    points = points + 100;
    notesOk[0] = 20;
  } 
  else if (((keyCode == UP)||(instr==hiHat_hit)) && (el2 > 465) && (el2<560)) {
    points = points + 100;
    notesOk[1] = 20;
  }
  else if (((keyCode == RIGHT||(instr==pedal_hit))) && (el3 > 465) && (el3<560)) {
    points = points + 100;
    notesOk[2] = 20;
  }
  else {
      lives = lives -1;
      if ((keyCode == LEFT) && (el1 < 465) || (el1 > 565)) {
        notesMissed[0] = 20; //20 Frames per second, array item 0 (i=0)
      }
      if ((keyCode == UP) && (el2 < 465) || (el2 > 565)) {
        notesMissed[1] = 20; 
      }
      if ((keyCode == RIGHT) && (el3 < 465) || (el3 > 565)) {
        notesMissed[2] = 20; 
      }
  } 
}
    
    
    
