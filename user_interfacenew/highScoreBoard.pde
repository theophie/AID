void highScoreBoard() {
  String textfile="";  
   if (modeConstant ==1)textfile="scoresE.txt";
   if (modeConstant ==2)textfile="scoresM.txt";
   if (modeConstant ==3)textfile="scoresH.txt";
   println("modeConstant",modeConstant);
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

  //for each value in the text increment the y by 60
  int y = 200;
   for (int i = 0 ; i < currentScores.length; i++) {   
     text(currentScores[i], 350, y); 
       y = y +60;
   }
}
