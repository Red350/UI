class PurgeButton extends Button
{
  
  PurgeButton(int x, int y, int w, int h, color c, String text)
  {
    super(x, y, w, h, c, text);
  }
  
  void clicked()
  {
    if(super.mouseOver)
    {
      if(clickedPlanet.purge == false)
      {
        clickedPlanet.purge();
      }
    }
  }
}