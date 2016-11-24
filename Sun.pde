class Sun
{ 
  float x = centreX;
  int y = centreY;
  int coreSize = 50;
  float theta1 = 0;
  float theta2 = 0;
  float theta3 = 0;
  float d = 100;
  int numPeaks = 20;
  int numSatellites = 200;
  int satelliteSize = 2;
  int direction = 1;
  int speed = 5;
  
  Sun()
  {
    
  }
  
  void render()  
  {
    noStroke();
    fill(c_sun.c);
    ellipse(x, y, coreSize, coreSize);
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
}