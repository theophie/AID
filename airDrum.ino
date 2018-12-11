const int bassBuzzer = 13; //buzzer to arduino pin 13
const int snareBuzzer = 12; //buzzer to arduino pin 12
const int hiHatBuzzer = 11; //buzzer to arduino pin 11

const int bassSensor = A0;
const int snareSensor = A1;
const int hiHatSensor = A2;

const int threshold = 300;

int bS = 0;
int sS = 0;
int hS= 0;

int snareTimer = -1;
int bassTimer = -1;
int hihatTimer = -1;

int snareSTimer = -1;
int bassSTimer = -1;
int hihatSTimer = -1;  

void setup(){
pinMode(bassBuzzer, OUTPUT); // Set buzzer as an output
pinMode(snareBuzzer, OUTPUT);
pinMode(hiHatBuzzer, OUTPUT);

pinMode(bassSensor, INPUT); // Set Piezo as an input
pinMode(snareSensor, INPUT);
pinMode(hiHatSensor, INPUT);

Serial.begin(9600); // Start serial communication at 9600 bbS
}

void loop(){
 sendHit();
  bS = analogRead(bassSensor);
  sS = analogRead(snareSensor);
  hS = analogRead(hiHatSensor);
//l1 - snare, l2 - bass, l3 - hihat

  char snare = 0;
  char bass = 0;
  char hihat = 0;

  if (Serial.available()) { 
     char aChar = Serial.read();
     if(aChar == 'a') { 
        delay(5);
        snare = Serial.read();
        bass = Serial.read();
        hihat = Serial.read();

        if (snare==1 && snareTimer == -1){
          digitalWrite(snareBuzzer,HIGH);
          snareTimer = 300;        
        }

       
        if (bass==1 && bassTimer == -1){
          digitalWrite(bassBuzzer,HIGH);
          bassTimer = 300;          
        }

        if (hihat==1 && hihatTimer == -1){
          digitalWrite(hiHatBuzzer,HIGH);
          hihatTimer = 300;
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

   if(bassTimer > 0) {
     bassTimer--;
     if(bassTimer == 0) { 
       noTone(bassBuzzer); 
       bassTimer = -1; 
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
       
 

int sSTimer = -1;
int bSTimer = -1;
int hSTimer = -1;

void sendHit(){
  
  if (sS >= threshold && sSTimer == -1){
    sSTimer = 300;
    Serial.println(1);
    }

   if (bS >= threshold && bSTimer == -1){
    bSTimer = 300;
     Serial.println(2);
    }

    if (hS >= threshold && hSTimer == -1){
    hSTimer = 300;
      Serial.println(3);
    }

    if(sSTimer > 0) {
      sSTimer--;
      if(sSTimer == 0) { 
        sSTimer = -1; 
      }
    }

    if(bSTimer > 0) {
      bSTimer--;
      if(bSTimer == 0) { 
        bSTimer = -1; 
      }
    }

    if(hSTimer > 0) {
      hSTimer--;
      if(hSTimer == 0) { 
        hSTimer = -1; 
      }
    }
} 
