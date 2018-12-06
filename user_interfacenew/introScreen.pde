// =========================== introScreen ==============================================

void introScreen() {
  background(light_grey);
  fill(255);
  textSize(50);
  textAlign(CENTER);
  text("Start game", 350, 200);
  image(drumkit, 100, 300, 500, 357);

  points = 0;
  notesTimer = 0;
  notesLineIndex = 0;
}
