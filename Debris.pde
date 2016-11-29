class Debris
{
  PVector pos;
  PVector velocity;
  float thetaDelta;
  float theta = 0;
  int size = 100;
  int aliveTime;
  
  Debris(float x, float y, float vx, float vy, float thetaDelta, int aliveTime)
  {
    pos = new PVector(x,y);
    velocity = new PVector(vx,vy);
    this.thetaDelta = thetaDelta;
    this.aliveTime = aliveTime;
  }
  
  void update()
  {
    // Update position and angle
    pos.add(velocity);
    theta += thetaDelta;
    
    // Fade colour for the last 60 frames of the debris' life
    if(aliveTime < 60 && aliveTime >= 0)
    {
      c_debris.setAlpha((int)map(aliveTime, 60, 0, 255, 0));
    }
    
    aliveTime--;
  }
  
  // Uses translate to rotate the debris around a central point
  // before drawing it in it's correct position
  void render()
  {
    if(aliveTime > 0)
    {
      strokeWeight(2);
      stroke(c_debris.c);
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(theta);
      line(0, -size/2, 0, size/2);
      popMatrix();
    }  
  }
}