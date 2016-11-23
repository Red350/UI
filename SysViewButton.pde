class SysViewButton extends Button
{
  SysViewButton(int x, int y, int w, int h, String text)
  {
    super(x, y, w, h, text);
  }
  
  void clicked()
  {
    if(super.mouseOver)
    {
      super.mouseOver = false;  // Clear mouseOver flag to prevent it from being clicked again
      mouseLock = true;
      state = 5;  // Transition from single planet to system view
      fadeIn.add(c_system);
      fadeIn.add(c_system_text);
      fadeIn.add(c_system_purge);
      fadeOut.add(c_singleplanet);
      fadeOut.add(c_button);
      fadeVariable = fadeSpeed;
    }
  }
}