import processing.serial.*;
String notes[];
String tempo[];
Serial myPort;  // Create object from Serial class

void setup() 
{
  size(200,200); //make our canvas 200 x 200 pixels big
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
 notes = loadStrings("data/notes.txt");
}

void draw() {
  
   if (keyPressed == true) 
  {                           //if we clicked in the window
   if (key == '1') {
      println("Start"); 
      readNotes();
    }   
  }
}
  
void readNotes(){
   for (int i = 0 ; i < notes.length; i++) {
   myPort.write(notes[i]);
   
   println(notes[i]);
   delay(2000); //this will be the tempo? 
 }
}
