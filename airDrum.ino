const int pedalBuzzer = 13; //buzzer to arduino pin 13
const int snareBuzzer = 12; //buzzer to arduino pin 12
const int hiHatBuzzer = 11; //buzzer to arduino pin 11

const int pedalSensor = A0;
const int snareSensor = A1;
const int hiHatSensor = A2;

const int threshold = 100;

int pS = 0;
int sS = 0;
int hS= 0;

int snareTimer = -1;
int pedalTimer = -1;
int hihatTimer = -1;

void setup(){
pinMode(pedalBuzzer, OUTPUT); // Set buzzer as an output
pinMode(snareBuzzer, OUTPUT);
pinMode(hiHatBuzzer, OUTPUT);

pinMode(pedalBuzzer, INPUT); // Set Piezo as an input
pinMode(snareSensor, INPUT);
pinMode(hiHatSensor, INPUT);

Serial.begin(9600); // Start serial communication at 9600 bps
}

void loop(){
  pS = analogRead(pedalSensor);
  sS = analogRead(snareSensor);
  hS = analogRead(hiHatSensor);
//l1 - snare, l2 - pedal, l3 - hihat

  if (Serial.available()) 
   { 
    
     char aChar = Serial.read();
     if(aChar == 'a')
     { 
        delay(5);
        char snare = Serial.read()-48;
        char pedal = Serial.read()-48;
        char hihat = Serial.read()-48;

        if (snare==1 && pedal==0 && hihat==1){
          if (snareTimer == -1) {
                tone(snareBuzzer, 1000); // Send 4KHz sound signal...
                snareTimer = 100;
             } 
        }else if(snare==0 && pedal ==0 && hihat==1){
           if (hihatTimer == -1) {
                tone(hiHatBuzzer, 1000); // Send 4KHz sound signal...
                hihatTimer = 100;
             } 
          }else if(snare==0 && pedal ==0 && hihat==0){
           noTone(snareBuzzer);
           snareTimer = -1;
           noTone(hiHatBuzzer);
           hihatTimer = -1;
           noTone(pedalBuzzer);
           pedalTimer = -1;
          }
     } 

      if(snareTimer > 0) {
        snareTimer--;
        if(snareTimer == 0) { 
          noTone(snareBuzzer); 
          snareTimer = -1; 
        }
     }

      if(hihatTimer > 0) {
        hihatTimer--;
        if(hihatTimer == 0) { 
          noTone(hiHatBuzzer); 
          hihatTimer = -1; 
        }
     }
   }
