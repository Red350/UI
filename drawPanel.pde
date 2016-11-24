float x = 200;
int y = 200;
int centreSize = 50;
float theta1 = 0;
float theta2 = 0;
float theta3 = 0;
float d = 100;
int numPeaks = 20;
int numSatellites = 200;
int satelliteSize = 2;
int direction = 1;
int speed = 5;

void drawPanel()
{
  x = cos(theta3)*10 + 100;
  theta3+=0.1;
  
  noStroke();
  fill(c_system_text.c);
  ellipse(x, y, centreSize, centreSize);
  fill(c_system_text.c);
  float temp = theta2;
  for(int i = 0; i < numSatellites; i++)
  {
    temp += TWO_PI/numSatellites*numPeaks;
    d = sin(temp)*10+50;
    ellipse(x + cos(theta1) * d, y - sin(theta1) * d, satelliteSize, satelliteSize);
    
    theta1 = theta1 + TWO_PI/numSatellites;
  }
  theta2 = theta2 +0.05;
  theta1 = 0;
}