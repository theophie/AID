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
int ySpeedSlow = 1; 
int ySpeedFast = 3; 

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
  
  stroke (255);
  strokeWeight (8);
  line(0,515,700,515);
  
  image(snare, 160, 570, 80, 80);
  image(hihat, 310, 550, 80, 120);
  image(bass, 460, 575, 80, 85);
  
  if (lives == 0) {
      mode = 2;
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
  else if (mode == 1) {  //handling clicks in game
  } 
  else if (mode == 2) {
    mode = 0; //switching to intro
  }
  else {
    mode = 0; //switching to intro
  }
}

void keyPressed() {
  if (key == CODED) { //checking if the key is coded
    if ((keyCode == LEFT) && (el1 > 465) && (el1<565)) {
      points = points + 100;
      image(correct, 200, 570, 80, 80);
    } 
    
    else if (keyCode == DOWN) {

    } 
  } else {
  }
}
