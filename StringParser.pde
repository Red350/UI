/* Class that parses a string and updates another string to give
   it the appearance of being typed.
   
   Regular characters are added to the typed string every 5 frames.
   The backspace character '\b' must be manually parsed as java
   tries to output it as a character rather than removing a character
   from the string.
   '\t' is used to add a delay between characters being typed, during which
   the cursor prompt will flash. The delay is set by the 2 characters following
   the the '\t' character e.g. "\t20".
   The delay number must be even, and the delay time is equivalent to half the
   delay time in seconds, so "\t20" would wait for 10 seconds.
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