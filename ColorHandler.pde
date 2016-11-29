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
  
  /* The methods below are currently unused.
     The original idea was to let the class worry about when the color
     had finished fading, but due to how bit operations work with signed
     numbers, I found this to be very difficult to get working.
     The current implementation uses two global arrays to fade in and out. */
  
  // Takes a value n and adds it to the alpha value of the colour
  // n should be a value between 1 and 255
  // Returns 0 when the fade in is complete, else returns 1
  boolean fadeIn(int n)
  {
    color temp = c;
    temp += 0x01000000 * n;
    // If temp is a negative number, shifting the bits to the right
    // results in the more significant bits being filled with 1's instead
    // of 0's. To fix this, we check the absolute value of temp's alpha bits
    int t1 = temp >> 24;
    int t2 = c >> 24;
    println("temp is " + Integer.toHexString(t1) + " \t colour is " + Integer.toHexString(t2));
    if (abs(temp >> 24) < (c >> 24))
    {
      c |= 0xFF000000;
      return true;
    }
    else
    {
      // Can safely store the new color value, as it has not overflowed
      c = temp;
      // Check if the value has faded in fully
      if (c >> 24 == 0xFF)
      {
        return true;
      }
      else
      {
        return false;
      }
    }
  }
  
  // Similar to fadeIn, except it returns 0 when the alpha value reaches 0
  boolean fadeOut(int n)
  {
    color temp = c;
    temp -= 0x01000000 * n;
    // If temp is greater than c, the color has overflowed
    // In this case set c to the minimum alpha value and return 0
    int t1 = temp >> 24;
    int t2 = c >> 24;
    println("temp is " + Integer.toHexString(t1) + " \t colour is " + Integer.toHexString(t2));
    if (temp >> 24 > abs(c >> 24))
    {
      c &= 0x00FFFFFF;
      return true;
    }
    else
    {
      // Can safely store the new color value, as it has not overflowed
      c = temp;
      // Check if the value has faded out fully
      if (c >> 24 == 0)
      {
        return true;
      }
      else
      {
        return false;
      }
    }
  }
}