class PurgeButton extends Button
{
  
  PurgeButton(int x, int y, int w, int h, String text, ColorHandler ch)
  {
    super(x, y, w, h, text, ch);
  }
  
  void clicked()
  {
    if(super.mouseOver)
    {
      super.clicked();
      if(clickedPlanet.purge == false)
      {
        clickedPlanet.purge();
      }
    }
  }
}