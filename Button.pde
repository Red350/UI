class Button
{
  int x, y, w, h;
  String text;
  int cornerRad = 10;
  boolean mouseOver = false;
  Button(int x, int y, int w, int h, String text)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
  }
  
  void render()
  {
    stroke(c_button.c);
    strokeWeight(1);
    
    if (mouseOver)
      fill(c_button.c);
    else
      noFill();
      
    rect(x,y,w,h,cornerRad);

    if (mouseOver)
      fill(0);
    else
      fill(c_button.c);
      
    textAlign(CENTER, CENTER);
    text(text, x + w/2, y + h/2);
  }
  
  void update()
  {
    mouseOver = (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h);
  }
}