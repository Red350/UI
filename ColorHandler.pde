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
  
  void setAlpha(int a)
  {
    c &= 0x00FFFFFF;
    c |= a << 24;
  }
  
  /* At the moment, setting n to anything that doesn't divide evenly into 255 
     will cause the fade methods to fail, as the values are stored as signed
     ints, and the check for overflow I was doing only works on unsigned
  */
  
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
      println("hello");
      println("aslkdfjlskdfa\nsdfsdf\nsdgfsdf\nsdfsdf\n");
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
    //println("temp is " + Integer.toHexString(t1) + " \t colour is " + Integer.toHexString(t2));
    if (temp >> 24 > abs(c >> 24))
    {
      c &= 0x00FFFFFF;
      println("aslkdfjlskdfa\nsdfsdf\nsdgfsdf\nsdfsdf\n");
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