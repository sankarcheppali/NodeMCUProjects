int id=99;
#include <SoftwareSerial.h>

SoftwareSerial sw(2, 3); // RX, TX

void setup() {
  Serial.begin(115200);
  Serial.println("Interfacfing arduino with nodemcu");
  sw.begin(115200);
}

void loop() {
  Serial.println("Sending data to nodemcu");
  int adc=analogRead(A0);
  Serial.print("{\"sensorid\":");
  Serial.print(id);//sensor id
  Serial.print(",");
  Serial.print("\"adcValue\":");
  Serial.print(adc);//offset
  Serial.print("}");
  Serial.println();
  
  sw.print("{\"sensorid\":");
  sw.print(id);//sensor id
  sw.print(",");
  sw.print("\"adcValue\":");
  sw.print(adc);//offset
  sw.print("}");
  sw.println();
  delay(5000);
}
