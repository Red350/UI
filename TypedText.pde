class TypedText
{
  String finalString;
  String displayString;
  int finalIndex = 0;
  int displayIndex = 0;
  int finalLength;
  
  TypedText(String finalString)
  {
    this.finalString = finalString;
    finalLength = finalString.length();
    displayString = "";
  }
  
  // Adds another character to the display string
  void update()
  {
    if (finalIndex < finalLength)
    {
      if (frameCount % 5 == 0)
      {
        if(finalString.charAt(finalIndex) == '\b')
        {
          //displayString = displayString.substring(0,displayString.length()-1);
          displayString = displayString.substring(0,displayIndex-1);
          displayIndex--;
        }
        else
        {
          displayString = displayString + finalString.charAt(finalIndex);
          displayIndex++;
        }
        finalIndex++;
      }
    }
    else
    {
      if(frameCount % 30 == 0)
      {
        if(finalIndex == finalLength)
        {
          displayString = displayString + "_";
          finalIndex++;
          displayIndex++;
        }
        else
        {
          displayString = displayString.substring(0,displayIndex-1);
          finalIndex--;
          displayIndex--;
        }
      }
    }
  }
  
  String toString()
  {
    return displayString;
  }
}