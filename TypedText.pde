class TypedText
{
  String inputString;
  String displayString;
  int i = 0;    // This is the index of the string being parsed
  int displayIndex = 0;  // This is the index of the string to be displayed
  int inputLength;
  int idleTime;
  char c;
  
  TypedText(String inputString)
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
        
        // Check if we're at a carriage return character, which to us means start idle time
        if(c == '\r')
        {
          idleTime = Integer.parseInt(inputString.substring(i+1,i+3));
          i+=3;
        }
        else
        {
          if (frameCount % 5 == 0)
          {
            if(inputString.charAt(i) == '\b')
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