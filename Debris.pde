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
    // By letting this loop to -1, it resets the red part of the colour back 
    // to it's full value, but since it will never draw when aliveTime is < 0, 
    // the fade still works correctly. The reason for doing this is it preps the colour
    // for the next time it is needed.
    if(aliveTime < 60 && aliveTime >= -1)
    {
      c_debris.setAlpha((int)map(aliveTime, 60, 0, 255, 0));
    }
    
    aliveTime--;
  }
  
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