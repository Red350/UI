class PurgeButton extends Button
{
  
  PurgeButton(int x, int y, int w, int h, String text)
  {
    super(x, y, w, h, text);
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