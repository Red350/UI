// Wrapper class for color
// Since color is just int, we can't make references to it,
// which this class fixes.
// The alpha value is stored in the 8 most significant bits of
// the color variable, so bit operations are required to manipulate it.
class ColorHandler
{
  color c;
  
  ColorHandler(color c)
  {
    this.c = c;
  }  
  
  // Takes a value n and adds it to the alpha value of the colour
  // n should be a value between 1 and 255
  // Returns 0 when the fade in is complete, else returns 1
  int fadeIn(int n)
  {
    color temp = c;
    temp += 0x01000000 * n;
    // If temp is less than c, the color has overflowed
    // In this case set c to the maximum alpha value and return 0
    if (temp < c)
    {
      c |= 0xFF000000;
      return 0;
    }
    else
    {
      // Can safely store the new color value, as it has not overflowed
      c = temp;
      // Check if the value has faded in fully
      if (c >> 24 == 0xFF)
      {
        return 0;
      }
      else
      {
        return 1;
      }
    }
  }
  
  // Similar to fadeIn, except it returns 0 when the alpha value reaches 0
  int fadeOut(int n)
  {
    color temp = c;
    temp -= 0x01000000 * n;
    // If temp is greater than c, the color has overflowed
    // In this case set c to the minimum alpha value and return 0
    if (temp > c)
    {
      c &= 0x00FFFFFF;
      return 0;
    }
    else
    {
      // Can safely store the new color value, as it has not overflowed
      c = temp;
      // Check if the value has faded out fully
      if (c >> 24 == 0)
      {
        return 0;
      }
      else
      {
        return 1;
      }
    }
  }
}