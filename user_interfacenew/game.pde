// ============================= game =====================================================

void drawCircles() {
   String[] list = split(notesLine, ',');

   if (Integer.parseInt(list[0]) == 1) {
     ellipse(200, el1, 50, 50); // Ellipse for snare
      el1 = el1 + ySpeed;
   }
   if (Integer.parseInt(list[1]) == 1) { 
       fill(grey);
       ellipse(350,el2, 50, 50); // Ellipse for bass
       el2 = el2 + ySpeed;
   }

   if (Integer.parseInt(list[2]) == 1) {  
        println("yes");
        fill(light_blue);
        ellipse(500, el3, 50, 50); // Ellipse for hi-hat
          el3 = el3 + ySpeed;
   }
 }


void game(int diff) {
 
  background(bg);
  
  int points_rounded = round(points);
  fill(255);
  text("Score: "+points_rounded, 630, 60); // Score of player
  textSize(18);
  image(back, 10, 40, 140, 40);
  
  fill(turquoise);  
  noStroke();
  if(notesTimer % diff == 0) readNotes(); 
  notesTimer++;

  drawCircles();
   
  stroke (green);
  strokeWeight (8);
  line(0,515,700,515);
  
  image(snare, 160, 570, 80, 80);
  image(bass, 310, 575, 80, 85);
  image(hihat, 460, 550, 80, 120);

   
  for(int i=0; i<3; i++) {  //an array for images
   if(notesOk[i] > 0) {
       if(i==0) image(correct, 200, 570, 80, 80); 
       if(i==1) image(correct, 350, 570, 80, 80); 
       if(i==2) image(correct, 500, 570, 80, 80); 
       notesOk[i]--;
       if(notesOk[i] == 0) notesOk[i] = -1;
    }
  }
  
  for(int i=0; i<3; i++) {
   if(notesMissed[i] > 0) {
       if(i==0) image(cross, 200, 570, 80, 80); 
       if(i==1) image(cross, 350, 570, 80, 80); 
       if(i==2) image(cross, 500, 570, 80, 80); 
       notesMissed[i]--;
       if(notesMissed[i] == 0) notesMissed[i] = -1;
    }
  }
  
  if (hsCount==0){
     highestScore = getHigherscore();
      hsCount=1;
  }
  
  if(points_rounded > highestScore){
   fill(255);
   text("Highscore: "+ points_rounded, 630, 40); // Score of player
  }else text("Highscore: "+ highestScore, 630, 40);
  
   if  (notesLineIndex == notes.length) { //end the game when you reach end of length array
     mode = 4;
   }
}

int getHigherscore(){
      String textfile="";  
      StringList scoresList;
      String hiScore;
     if (modeConstant ==1)textfile="scoreE.xml";
     if (modeConstant ==2)textfile="scoreN.xml";
     if (modeConstant ==3)textfile="scoreH.xml";
   
     xml = loadXML(textfile);
     XML[] children = xml.getChildren("score");
        scoresList = new StringList();
        if (children.length ==0){
          return 0;
        }else{
          for (int i = 0; i < children.length; i++) {      
        String score = children[i].getString("score");       
        scoresList.append(score);
      }
      
    scoresList.sort();
    scoresList.reverse();
    String[] sortedScore = scoresList.array();
    hiScore = sortedScore[0];
    return int(hiScore);
        }
      
}
