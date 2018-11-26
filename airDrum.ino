const int legBuzzer = 13; //buzzer to arduino pin 13
const int snareBuzzer = 12; //buzzer to arduino pin 13
char val; // Data received from the serial port

void setup(){
pinMode(legBuzzer, OUTPUT); // Set buzzer - pin 9 as an output
pinMode(snareBuzzer, OUTPUT);
Serial.begin(9600); // Start serial communication at 9600 bps
}

void loop(){
 if (Serial.available()) 
   { // If data is available to read,
     val = Serial.read(); // read it and store it in val
      if (val == '1') 
       { // If 1 was received
        tone(snareBuzzer, 4000); // Send 1KHz sound signal...
        delay(500);
        noTone(snareBuzzer);   
       } else if (val == '2') {
          tone(legBuzzer, 4000);  // Stop sound...
          delay(500);
          noTone(legBuzzer);    
       }else{
          noTone(legBuzzer);  
          noTone(snareBuzzer);  
        }
       
   }
}
