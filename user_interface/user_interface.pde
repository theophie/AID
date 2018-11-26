PImage bg, drums;

void setup(){
  size(700,700);
  bg = loadImage("background.jpg");
  bg.resize(700, 700);
  
  drums = loadImage("drum_blue.png");

}

void draw(){
  background(bg);
  image(drums, 200, 46, 70, 70);
  image(drums, 350, 46, 70, 70);
  image(drums, 500, 46, 70, 70);
}
