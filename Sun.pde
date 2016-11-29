/* Sun object in the centre of the system.
 * Consists of a center circle, and a wave of satellites
 * travelling in a sin wave pattern around the outside.
 *
 * Can get some very cool patterns by changing fields below.
 */
 
class Sun
{ 
  int x, y;
  int coreSize = 50;
  float theta = 0;
  float rotationSpeed = 0;
  float d = 100;  // distance from any one dot to the centre of the sun
  int numPeaks = 20;  // number of peaks in the outer wave
  int numSatellites = 150;  // number of dots in the wave
  int satelliteSize = 2;
  int direction = 1;
  int waveHeight = 5;
  
  Sun(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  void render()  
  {
    noStroke();
    fill(c_sun.c);
    ellipse(x, y, coreSize, coreSize);
    float tempRot = rotationSpeed;
    for(int i = 0; i < numSatellites; i++)
    {
      tempRot += TWO_PI/numSatellites*numPeaks;
      d = sin(tempRot)*waveHeight+40;
      ellipse(x + cos(theta) * d, y - sin(theta) * d, satelliteSize, satelliteSize);
      theta = theta + TWO_PI/numSatellites;
    }
    rotationSpeed += 0.05;
    theta = 0;
  }
}