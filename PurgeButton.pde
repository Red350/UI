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
        purgeDebris = new Debris[numDebris];
        Debris d;
        for(int i = 0; i < numDebris; i++)
        {
          d = new Debris(centreX, centreY,random(-10,+10),random(-10,+10),random(0,PI/32), (int)random(180,240));
          purgeDebris[i] = d;
        }
      }
    }
  }
  
}