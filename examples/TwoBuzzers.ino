

const int pedalBuzzer = 13; //buzzer to arduino pin 13
const int snareBuzzer = 12; //buzzer to arduino pin 12
const int hiHatBuzzer = 11; //buzzer to arduino pin 11

const int pedalSensor = 0;
const int snareSensor = 1;
const int hiHatSensor = 2;

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


 if (sS >= threshold && snareTimer == -1) {
    tone(snareBuzzer, 4000); // Send 4KHz sound signal...
    snareTimer = 400;
 }

  if(snareTimer > 0) {
    snareTimer--;
    if(snareTimer == 0) { 
      noTone(snareBuzzer); 
      snareTimer = -1; 
    }
 }
if (pS >= threshold && pedalTimer == -1) {
    tone(pedalBuzzer, 4000); // Send 4KHz sound signal...
    pedalTimer = 400;
 }

  if(pedalTimer > 0) {
    pedalTimer--;
    if(pedalTimer == 0) { 
      noTone(pedalBuzzer); 
      pedalTimer = -1; 
    } 
  }   

  if (hS >= threshold && hihatTimer == -1) {
    tone(hiHatBuzzer, 4000); // Send 4KHz sound signal...
    hihatTimer = 600;
 }

  if(hihatTimer > 0) {
    hihatTimer--;
    if(hihatTimer == 0) { 
      noTone(hiHatBuzzer); 
      hihatTimer = -1; 
    } 
  }

}
  
