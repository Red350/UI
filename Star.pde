/* Stars randomly change their brightness every 5 frames
 * to give the illusion that they are flickering.
 */
 
class Star
{
  PVector pos;
  PVector velocity;
  int size;
  color c;
  
  Star(int x, int y, float vx, float vy, int size)
  {
    pos = new PVector(x, y);
    velocity = new PVector(vx, vy);
    this.size = size;
  }
  
  void render()
  {
    strokeWeight(2);
    if(frameCount % 5 == 0)
      c = (int)random(150,255);
    stroke(c);
    point(pos.x, pos.y);
  }
}