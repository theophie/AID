// =========================== gameOver =================================================

void gameOver() {
  background(bg);
  fill(255, 80);
  noStroke();
  rectMode(CENTER);  // display rectangle in center
  rect(350, 350, 420, 350);
  fill(turquoise);
  textSize(50);
  int points_rounded = round(points);
  text("Your Highscore:", 350, 250);
  text(points_rounded+" Points", 350, 350);
  image(party, 420, 330, 200, 200);
  int finalscore_rounded = round(finalscore);
  finalscore = (points/2200)*100; //2200 is the maximum score you can get currently
  text(finalscore_rounded+" %", 350, 450);
}
