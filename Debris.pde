class Debris
{
  PVector pos;
  PVector velocity;
  float thetaDelta;
  float theta = 0;
  int size = 100;
  int aliveTime;
  color c = c_singleplanet.c;
  
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
    int temp;
    if(aliveTime <= 60)
    {
      temp = (int)map(aliveTime, 60, 0, 255, 0);
      c = color(temp,0,0);
    }
    
    aliveTime--;
  }
  
  void render()
  {
    if(aliveTime > 0)
    {
      stroke(c);
      //line(pos.x,pos.y, pos.x + size, pos.y + size);
      line(pos.x,pos.y, pos.x + cos(theta)*size, pos.y - sin(theta)*size);
    }  
  }
}