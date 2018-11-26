const int pedalBuzzer = 13; //buzzer to arduino pin 13
const int snareBuzzer = 12; //buzzer to arduino pin 12
const int crushBuzzer = 11; //buzzer to arduino pin 12

const int pedalSensor = 0;
const int snareSensor = 1;
const int crushSensor = 2;

char val; // Data received from the serial port

void setup(){
pinMode(pedalBuzzer, OUTPUT); // Set buzzer - pin 9 as an output
pinMode(snareBuzzer, OUTPUT);
Serial.begin(9600); // Start serial communication at 9600 bps
}

void loop(){
//  pS = analogRead(pedalSensor);
  //sS = analogRead(snareSensor);
  //aS = analogRead(crushSensor);
  //we need to send which sensor was used and the pressure that it was used (sensorName,pressure)
  
 if (Serial.available()) 
   { // If data is available to read,
     val = Serial.read(); // read it and store it in val
      if (val == '1') 
       { // If 1 was received
        tone(snareBuzzer, 4000); // Send 1KHz sound signal...
        delay(500);
        noTone(snareBuzzer);   
       } else if (val == '2') {
          tone(pedalBuzzer, 4000);  // Stop sound...
          delay(500);
       }  noTone(crushBuzzer);  

   }else if (val == '3') {
          tone(crushBuzzer, 4000);  // Stop sound...
          delay(500);
          noTone(crushBuzzer);     
       }else{
          noTone(pedalBuzzer);  
          noTone(snareBuzzer);  
           noTone(crushBuzzer);  
        }
   }
