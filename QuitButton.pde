class QuitButton extends Button
{
  
  QuitButton(int x, int y, int w, int h, String text, ColorHandler ch)
  {
    super(x, y, w, h, text, ch);
  }
  
  void clicked()
  {
    if(super.mouseOver)
    {
      super.clicked();
      super.mouseOver = false;
      mouseLock = true;
      state = 6;
      fadeIn = screen_intro;
      fadeOut = screen_system;
      fadeVariable = fadeSpeed;
    }
  }
}