

const int pedalSensor =A0;
const int snareSensor=A1;
const int hihatSensor=A4;

const int threshold = 300;

int pS = 0;
int sS=0;
int hS=0;

//int snareTimer = -1;
int pedalTimer = -1;
//int hihatTimer = -1;


//int noteBuzz; // Data received from the serial port
//int noteBuzzer;
//char noteBuzzer[3];


void setup(){
Serial.begin(9600); // Start serial communication at 9600 bps
}

void loop(){
  pS = analogRead(pedalSensor);
  sS=analogRead(snareSensor);
  hS=analogRead(hihatSensor);

  
  
  // if the sensor reading is greater than the threshold:
//  for(int i=0,i<3,i++){
  if (hS >= threshold && pedalTimer == -1) {
        pedalTimer = 200;      
        //map(pS, 0, 1023, 0, 100); 
        //Serial.write(pS);
        Serial.write(1);

    }

      if (sS >= threshold && pedalTimer == -1) {
        pedalTimer = 200;      
        //map(pS, 0, 1023, 0, 100); 
        //Serial.write(pS);
        Serial.write(101);

    }

  if (pS >= threshold && pedalTimer == -1) {
        pedalTimer = 200;      
        //map(pS, 0, 1023, 0, 100); 
        //Serial.write(pS);
        Serial.write(201);

    }
  if(pedalTimer > 0) {
    pedalTimer--;
    if(pedalTimer == 0) { 
      pedalTimer = -1; 
    }
  }


// if (pS >= threshold && pedalTimer == -1) {
//     map(pS, 0, 1023, 0, 100); 
//    pedalTimer = 1000;
// }
//
//  if(pedalTimer > 0) {
//    pedalTimer--;
//    if(pedalTimer == 0) { 
//    //  pS = map(0, 0, 0, 0, 0);
//      pedalTimer = -1; 
//    }
// }
//
// if (sS >= threshold && snareTimer == -1) {
//     map(sS, 0, 1023, 0, 100); 
//    snareTimer = 1000;
// }
//
//  if(snareTimer > 0) {
//    snareTimer--;
//    if(snareTimer == 0) { 
//    //  pS = map(0, 0, 0, 0, 0);
//      snareTimer = -1; 
//    }
// }
//
// if (hS >= threshold && hihatTimer == -1) {
//     map(hS, 0, 1023, 0, 100); 
//    hihatTimer = 1000;
// }
//
//  if(hihatTimer > 0) {
//    hihatTimer--;
//    if(hihatTimer == 0) { 
//    //  pS = map(0, 0, 0, 0, 0);
//      hihatTimer = -1; 
//    }
// }

    
//      if (sS >= threshold) {
//      
//        map(sS, 0, 1023, 101, 200); 
//        Serial.write(sS);
//        //delay(100);
//      
//        
//        //Serial.println(pS);// Stop sound...
//    }
//    if (hS >= threshold) {
//      
//        map(hS, 0, 1023, 201, 300); 
//        Serial.write(hS);
//        //delay(100);
//
//     
//      
        
 
    

    
    

 
       
}
