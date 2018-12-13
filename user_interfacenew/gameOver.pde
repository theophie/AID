// =========================== gameOver =================================================

void gameOver() {
  int per = noteCount * 100;
  background(bg);
  fill(255, 80);
  noStroke();
  rectMode(CENTER);  // display rectangle in center
  rect(350, 350, 420, 350);
  textSize(50);
  points_rounded = round(points);
  fill(orange);
  text("Your Highscore:", 350, 250);
  fill(0);
  text(points_rounded+" Points", 350, 350);
  image(party, 420, 330, 200, 200);
  int finalscore_rounded = round(finalscore);
  finalscore = (points/per)*100; //1500 is the maximum score you can get currently in normal/medium mode
  text(finalscore_rounded+" %", 350, 450);
  fill(orange);
  textSize(40);
  text("Enter your name:"+ username , 350, 650);

}

// =========================== Highscores =================================================

void highscore(int us){
   String textfile="";
   String userscore ="";
   
   if (username=="")username="UKN";
   if (us==00)us=0000;
   println("lngth",String.valueOf(us).length());
   if (String.valueOf(us).length()<4) userscore = "0" + str(us); else userscore = str(us); // add a zero infront of 3digit numbers

   if (modeConstant ==1)textfile="scoreE.xml";
   if (modeConstant ==2)textfile="scoreN.xml";
   if (modeConstant ==3)textfile="scoreH.xml";
  
   xml = loadXML(textfile);
   XML score = xml.addChild("score");
   score.setString("score", userscore);
   score.setString("username", username);
   saveXML(xml, textfile);
}
