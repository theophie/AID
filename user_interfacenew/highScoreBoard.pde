void highScoreBoard() {
  String textfile="";  
  StringList scoresList;
   
   if (modeConstant ==1)textfile="scoreE.xml";
   if (modeConstant ==2)textfile="scoreN.xml";
   if (modeConstant ==3)textfile="scoreH.xml";
  
   xml = loadXML(textfile);
   XML[] children = xml.getChildren("score");
      scoresList = new StringList();
    for (int i = 0; i < children.length; i++) {      
      String score = children[i].getString("score");
      String username = children[i].getString("username");
      scoresList.append(score + " " + username);
    }
  scoresList.sort();
  scoresList.reverse();
  String[] sortedScore = scoresList.array();
 
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
   for (int i = 0 ; i < sortedScore.length; i++) {   
     text(sortedScore[i], 350, y); 
       y = y +60;
       if (i==5)return;
   }
}
