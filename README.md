# vechicle-Accident-Prevention
// Ultrasonic Sensor Pins
const int trigPin = 9;
const int echoPin = 10;

// Output devices
const int buzzer = 6;
const int led = 7;

// Distance threshold in cm
const int dangerDistance = 20;

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(buzzer, OUTPUT);
  pinMode(led, OUTPUT);
  
  Serial.begin(9600);
}

void loop() {
  long duration;
  int distance;

  // Trigger the ultrasonic sensor
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // Measure the duration of echo
  duration = pulseIn(echoPin, HIGH);
  distance = duration * 0.034 / 2;

  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.println(" cm");

  // Safety check
  if (distance <= dangerDistance) {
    digitalWrite(buzzer, HIGH);
    digitalWrite(led, HIGH);
    // Stop motors here if you're using motor driver
  } else {
    digitalWrite(buzzer, LOW);
    digitalWrite(led, LOW);
    // Allow motors to move
  }

  delay(200);
}
