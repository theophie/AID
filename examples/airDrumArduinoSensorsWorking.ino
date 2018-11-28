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

//int noteBuzz; // Data received from the serial port
//int noteBuzzer;
//char noteBuzzer[3];


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

  // if the sensor reading is greater than the threshold:
  if (pS >= threshold) {
        tone(pedalBuzzer, 4000); // Send 4KHz sound signal...
        delay(500);
        noTone(pedalBuzzer);    // Stop sound...
    }
    
  if (sS >= threshold) {
        tone(snareBuzzer, 4000); // Send 4KHz sound signal...
        delay(500);
        noTone(snareBuzzer);    // Stop sound...
    }

  if (hS >= threshold) {
        tone(hiHatBuzzer, 4000); // Send 4KHz sound signal...
        delay(500);
        noTone(hiHatBuzzer);    // Stop sound...
    }
}
  
