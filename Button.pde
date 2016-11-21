class Button
{
  int x, y, w, h;
  String text;
  color c;
  int cornerRad = 10;
  boolean mouseOver = false;
  Button(int x, int y, int w, int h, color c, String text)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    this.text = text;
  }
  
  void render()
  {
    stroke(c);
    strokeWeight(1);
    
    if (mouseOver)
      fill(c);
    else
      noFill();
      
    rect(x,y,w,h,cornerRad);

    if (mouseOver)
      fill(0);
    else
      fill(c);
      
    textAlign(CENTER, CENTER);
    text(text, x, y);
  }
  
  void update()
  {
    mouseOver = (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h);
  }
}