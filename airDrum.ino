const int pedalBuzzer = 13; //buzzer to arduino pin 13
const int snareBuzzer = 12; //buzzer to arduino pin 12
const int hiHatBuzzer = 11; //buzzer to arduino pin 11

const int pedalSensor = A0;
const int snareSensor = A1;
const int hiHatSensor = A2;

const int threshold = 300;

int pS = 0;
int sS = 0;
int hS= 0;

int snareTimer = -1;
int pedalTimer = -1;
int hihatTimer = -1;

int snareSTimer = -1;
int pedalSTimer = -1;
int hihatSTimer = -1;  

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
 sendHit();
  pS = analogRead(pedalSensor);
  sS = analogRead(snareSensor);
  hS = analogRead(hiHatSensor);
//l1 - snare, l2 - pedal, l3 - hihat

  char snare = 0;
  char pedal = 0;
  char hihat = 0;

  if (Serial.available()) { 
     char aChar = Serial.read();
     if(aChar == 'a') { 
        delay(5);
        snare = Serial.read()-48;
        pedal = Serial.read()-48;
        hihat = Serial.read()-48;

        if (snare==1 && snareTimer == -1){
          snareTimer = 200;
          tone(snareBuzzer, 2000); // Send 4KHz sound signal...
        }

        if (pedal==1 && pedalTimer == -1){
          pedalTimer = 200;
          tone(pedalBuzzer, 2000); // Send 4KHz sound signal...
        }

        if (hihat==1 && hihatTimer == -1){
          hihatTimer = 200;
          tone(hiHatBuzzer, 2000); // Send 4KHz sound signal...
        }

     }      
   }

   if(snareTimer > 0) {
     snareTimer--;
     if(snareTimer == 0) { 
       noTone(snareBuzzer); 
       snareTimer = -1; 
     }
   } 

   if(pedalTimer > 0) {
     pedalTimer--;
     if(pedalTimer == 0) { 
       noTone(pedalBuzzer); 
       pedalTimer = -1; 
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
       
 


int sendCounter=-1;

void sendHit(){
if (sS >= threshold){
   Serial.println(1);
   }

   if (pS >= threshold){
   Serial.println(2);
   }

   if (hS >= threshold){
   Serial.println(3);
   }
  
//int instr [3]={0,0,0};

//if (sendCounter=-1){
//  if (sS >= threshold){
//    instr[0] = 1;
//    sendCounter=1;
//    }
//
//   if (pS >= threshold){
//    instr[1] = 1;
//    sendCounter=1;
//    }
//
//    if (hS >= threshold){
//    instr[2] = 1;
//    sendCounter=1;
//    }
//  }
//
//  if (sendCounter=1){
//   Serial.println("a");
//   Serial.println(instr[0]);
//   Serial.println(instr[1]);
//   Serial.println(instr[2]);
//   sendCounter=-1; 
//  }
} 
  
