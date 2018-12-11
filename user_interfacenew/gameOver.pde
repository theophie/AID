// =========================== gameOver =================================================

void gameOver() {
  background(bg);
  fill(255, 80);
  noStroke();
  rectMode(CENTER);  // display rectangle in center
  rect(350, 350, 420, 350);
  fill(turquoise);
  textSize(50);
  points_rounded = round(points);
  text("Your Highscore:", 350, 250);
  text(points_rounded+" Points", 350, 350);
  image(party, 420, 330, 200, 200);
  int finalscore_rounded = round(finalscore);
  finalscore = (points/2200)*100; //2200 is the maximum score you can get currently
  text(finalscore_rounded+" %", 350, 450);
  
  text("Enter your name:"+ username , 350, 650);

}
// =========================== Highscores =================================================

void highscore(int us){
  String textfile="";
  String userscore ="";
  StringList scores;
  
   if (String.valueOf(us).length()<4) userscore = "0" + str(us); // add a zero infront of 3digit numbers

   if (modeConstant ==1)textfile="scoresE.txt";
   if (modeConstant ==2)textfile="scoresM.txt";
   if (modeConstant ==3)textfile="scoresH.txt";
   
    String[] currentScores = loadStrings(textfile); //load textfile into a string array
    
    scores = new StringList();
    if (username=="")username="UKN";
    if(currentScores.length>0){
      for (int i = 0 ; i < currentScores.length; i++) {
       scores.append(currentScores[i]); //add to a stringlist
      }
       scores.append(userscore + " " +username);
       scores.sort(); //sort them
        if(currentScores.length>4){
          scores.remove(0); //if there are 5 scores then remove the first one
        }
    }else scores.append(userscore + " " +username);
    
    String[] sortedScore = scores.array();
    saveStrings(textfile, sortedScore);
}
