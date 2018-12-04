import processing.serial.*;
String notes[];
String tempo[];
Serial myPort;  // Create object from Serial class
String val;
int instr;
void setup() 
{
  size(200,200); 
  String portName = Serial.list()[0]; 
  myPort = new Serial(this, portName, 9600);
   notes = loadStrings("data/notes.txt");
   tempo = loadStrings("data/tempo.txt");
}

void draw() {
   if ( myPort.available() > 0) 
      {  // If data is available,
        instr = myPort.read();    
      } 
      
      if (instr==51){
        //value = 3
         println("hiHat");
      }else if (instr==50){
        //value = 2
       println("Pedal");
     }else if (instr==49){
       //value = 1
       println("Snare");
     }

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
     delay(10000);
   }
}
