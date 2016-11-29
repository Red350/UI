/* Button super class that all other buttons inherit from */

class Button
{
  int x, y, w, h;
  String text;
  int cornerRad = 10;
  boolean mouseOver = false;
  boolean soundPlayed = false;
  ColorHandler cHandler;
  
  Button(int x, int y, int w, int h, String text, ColorHandler cHandler)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
    this.cHandler = cHandler;
  }
  
  void render()
  {
    stroke(cHandler.c);
    strokeWeight(1);
    
    if (mouseOver)
      fill(cHandler.c);
    else
      noFill();
      
    rect(x,y,w,h,cornerRad);

    if (mouseOver)
      fill(0);
    else
      fill(cHandler.c);
      
    textAlign(CENTER, CENTER);
    textSize(12);
    text(text, x + w/2, y + h/2);
  }
  
  void update()
  {
    if(mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h)
    {
      if(soundPlayed == false)
      {
        mouseOverSound.play();
        soundPlayed = true;
      }
      mouseOver = true;
    }
    else
    {
      mouseOver = false;
      soundPlayed = false;
    }
  }
  
  void clicked()
  {
    buttonClickSound.play();
  }
}