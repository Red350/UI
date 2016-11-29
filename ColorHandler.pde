/* Wrapper class for color.
 * Since color's are just ints, there are no in-built methods to alter them.
 * This class contains methods to individually change the rgb and alpha values of a color.
 *
 * The byte layout of colors is AARRGGBB. To change part of a color, the two relevant bytes
 * must be cleared using logical AND, then written with the new value by bit shifting it and
 * storing it with logical OR.
 */
 
class ColorHandler
{
  color c;
  
  ColorHandler(color c)
  {
    this.c = c;
  }
  
  // The four methods below set the rgb or alpha value of a colour.
  
  void setAlpha(int alpha)
  {
    c &= 0x00FFFFFF;
    c |= alpha << 24; 
  }
  
  void setRed(int red)
  {
    c &= 0xFF00FFFF;
    c |= red << 16;
  }
  
  void setGreen(int green)
  {
    c &= 0xFFFF00FF;
    c |= green << 8;
  }
  
  void setBlue(int blue)
  {
    c &= 0xFFFFFF00;
    c |= blue;
  }
}