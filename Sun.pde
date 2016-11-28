class Sun
{ 
  int x, y;
  int coreSize = 50;
  float theta = 0;
  float rotation = 0;
  float d = 100;  // distance from any one dot to the centre of the sun
  int numPeaks = 20;
  int numSatellites = 150;
  int satelliteSize = 2;
  int direction = 1;
  int speed = 5;
  
  Sun(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  void render()  
  {
    noStroke();
    fill(c_sun.c);
    ellipse(x, y, coreSize, coreSize);
    float temp = rotation;
    for(int i = 0; i < numSatellites; i++)
    {
      temp += TWO_PI/numSatellites*numPeaks;
      d = sin(temp)*5+40;
      ellipse(x + cos(theta) * d, y - sin(theta) * d, satelliteSize, satelliteSize);
      
      theta = theta + TWO_PI/numSatellites;
    }
    rotation += 0.05;
    theta = 0;
  }
}