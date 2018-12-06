// =========================== gameOver =================================================

void gameOver() {
  background(bg);
  fill(255, 80);
  noStroke();
  rectMode(CENTER);  // display rectangle in center
  rect(350, 280, 420, 200);
  fill(turquoise);
  textSize(50);
  text("Your Highscore:", 350, 250);
  text(""+points, 350, 350);
  image(party, 420, 290, 200, 200);
}
