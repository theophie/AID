import processing.serial.*;
String notes[];
String tempo[];
Serial myPort;  // Create object from Serial class
String val;
void setup() 
{
  size(200,200); 
  String portName = Serial.list()[0]; 
  myPort = new Serial(this, portName, 9600);
   notes = loadStrings("data/notes.txt");
   tempo = loadStrings("data/tempo.txt");
}

void draw() {
   

   if (keyPressed == true) 
  {                           
   if (key == '1') {
      println("Start");   
      readNotes();
    } 
  }
}
  
void readNotes(){
   for (int i = 0 ; i < notes.length; i++) {
     String notesLine= notes[i];    
     String[] list = split(notesLine, ',');
     println(notesLine);
     myPort.write('a');
     myPort.write(list[0]);
     myPort.write(list[1]);
     myPort.write(list[2]);
     delay(int(tempo[i]));
   }
}
