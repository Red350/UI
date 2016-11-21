class Slider
{
  int x, y, w, h;
  int value;
  
  Slider(int x, int y, int w, int h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    value = w/2;
  }
  
  void render()
  {
    strokeWeight(1);
    stroke(255);
    fill(0);
    rect(x, y, w, h);
    rect(x, y, h+10, h+10);
  }
  
}