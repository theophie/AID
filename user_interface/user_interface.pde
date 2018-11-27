PImage bg, snare, hihat, bass;

void setup(){
  size(700,700);
  bg = loadImage("background.jpg");
  bg.resize(700, 700);

  snare = loadImage("snare.png");
  
  hihat = loadImage("hihat.png");
  
  bass = loadImage("bass.png");

}

void draw(){
  background(bg);
  ellipse(200, 50, 50, 50);
  ellipse(350, 50, 50, 50);
  ellipse(500, 50, 50, 50);
  image(snare, 160, 570, 80, 80);
  image(hihat, 310, 550, 80, 120);
  image(bass, 460, 575, 80, 85);
} 
