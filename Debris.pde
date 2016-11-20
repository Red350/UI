class Debris
{
  PVector pos;
  PVector velocity;
  float theta;
  
  Debris(float x, float y, float vx, float vy, float theta)
  {
    pos = new PVector(x,y);
    velocity = new PVector(vx,vy);
    theta = this.theta;
  }
  
  void update()
  {
    pos.add(velocity);
  }
  
  void render()
  {
    stroke(c_singleplanet.c);
    translate(centreX, centreY);
    line(pos.x,pos.y,pos.x+10,pos.y+10);
  }
}