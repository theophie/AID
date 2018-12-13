void highScoreBoard() {
  String textfile="";  
   if (modeConstant ==1)textfile="scoresE.txt";
   if (modeConstant ==2)textfile="scoresM.txt";
   if (modeConstant ==3)textfile="scoresH.txt";

  String[] currentScores = loadStrings(textfile);
  currentScores = reverse(currentScores);
 
  background(bg);
  fill(255, 80);
  noStroke();
  rectMode(CENTER);  // display rectangle in center
  rect(350, 350, 500, 600);
  textAlign(CENTER);
  textSize(50);
  fill(orange);
  text("Lead Board", 350, 150);
  fill(0);
  textSize(35);
  text(currentScores[0], 350, 200); 
  text(currentScores[1], 350, 260); 
  text(currentScores[2], 350, 320); 
  text(currentScores[3], 350, 380); 
  text(currentScores[4], 350, 440); 
  text(currentScores[5], 350, 500); 
}
