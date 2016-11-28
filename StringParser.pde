/* Class that parses an input string and updates a display string to give
   it the appearance of being typed.
   
   Regular characters are added to the display string every 5 frames.
   
   The '$' character is used to make it appear as if text is being backspaced.
   Anytime a '$' is parsed, a character is removed from the display string.
   
   The '^' symbol, followed by two numbers, e.g. "^10" is used to make the terminal
   wait before adding more characters to the display string. During this wait time
   an underscore is added and removed from the display string to make it look like
   the cursor is flashing, waiting for input.
   The delay number must be even, and the delay time is equivalent to half the
   delay number in seconds, so "^10" would wait for 5 seconds.
*/

class StringParser
{
  String inputString;
  String displayString;
  int i = 0;    // This is the index of the string being parsed
  int displayIndex = 0;  // This is the index of the string to be displayed
  int inputLength;
  int idleTime;
  char c;
  boolean finished = false;
  
  StringParser(String inputString)
  {
    this.inputString = inputString;
    inputLength = inputString.length();
    displayString = "";
  }
  
  // Parse the input string
  void update()
  {
    // Only parse the string if not if cursor not sitting idle
    if (idleTime <= 0)
    {
      // Check to see if we've reached the end of the string
      if (i < inputLength)
      {
        c = inputString.charAt(i);
        
        // Check if we're at a control character
        if(c == '^')
        {
          idleTime = Integer.parseInt(inputString.substring(i+1,i+3));
          i+=3;
        }
        else
        {
          if (frameCount % 2 == 0)
          {
            if(inputString.charAt(i) == '$')
            {
              displayString = displayString.substring(0,displayIndex-1);
              displayIndex--;
            }
            else
            {
              displayString = displayString + inputString.charAt(i);
              displayIndex++;
            }
            i++;
          }
        }
      }
      else
      {
        // At this point the string is fully parsed
        // I set idle time to 100 to allow more than enough time for the screen to fade
        finished = true;
        idleTime = 100;
      }
    }
    else
    {
      if(frameCount % 30 == 0)
      {
        if(idleTime % 2 == 0)
        {
          displayString = displayString + "_";
        }
        else
        {
          displayString = displayString.substring(0,displayString.length()-1);
        }
        idleTime--;
      }
    }
  }
  
  String toString()
  {
    return displayString;
  }
}