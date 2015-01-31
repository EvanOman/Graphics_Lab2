/*
  Overview:
  This processing script performs the following operations on the "lab2.jpg" image:
    1. Displays the RGB channel values of the pixel underneath the mouse cursor.
    2. Allows the user to show only the r g or b channel by selecting the corresponding key on the keyboard. Any other
       key selection will result in displaying the original image.
  
 Assumptions:
   -Users will only use lower case letters for input
   -Any time a 'r', 'g', or 'b' key is pressed(once) the image channels will be processed once. Thus the alternate 
    channel will be shown until a different channel is selected.
   -Once any other key is pressed the image will be returned to the original
 */

/*
  Global PImage objects which are used to manipulate/display the "lab2.jpg"
*/
PImage baseImage;
PImage modImage;

/*
Global char defining the current channel mode:
 -a: normal image
 -r: red channel
 -g: green channel
 -b: blue channel
*/
char channelMode = 'a';

/* Called at the beginning of execution, sets params and loads the images */
void setup()
{
  baseImage = loadImage("lab2.jpg");
  modImage = loadImage("lab2.jpg");
  size(baseImage.width, baseImage.height);
}

/* Continuous refresh function used to draw the images and listen for user input(via mouse and keyboard) */
void draw()
{
  background(255);
  
  /* Draws our two images to the screen */
  image(baseImage, 0, 0);
  image(modImage, 0, 0);
  
  /* Sets some text characterists */
  textSize(30);
  fill(0);
   
  /* Grabs the rgb colors of the pixel underneath the mouse(always on the original image) */
  color c = baseImage.get(mouseX, mouseY);
  int r = (int)red(c);
  int g = (int)green(c);
  int b = (int)blue(c);

  /* Prints the image channel values gathered above to the sceen */
  text("RGB(" + r + ", " + g + ", " + b + ")", 10, 40);

 /* Here is where we handle the user input which switches the channel mode */
  if (keyPressed) 
  {
    /* Only care if the key pressed would change the displayed image */
    if (key != channelMode)
    {
      /* If the chosen key is one of the red green or blue channels, we change the channel mode and modify the pixels */
      if (key == 'r' || key == 'g' || key == 'b')
      {
        channelMode = key;
        setChannels();
      }
      /*
        Otherwise the user must have hit a different key, default to clearing the modified umage
        **Note that this case can be hit even if the channel mode is already 'a'. This is not an issue because 
          there is very little cost to clearing the screen and no data is affected(we just setting the size to 0
      */
      else
      {
        channelMode = 'a';
        clearModImage();
      }
       
    }
  }
}

/* Loops over all the pixels and sets the channels as desired*/
void setChannels()
{
  /* Reloads a fresh image */
  resetModImage();
  
   /* Grabs the (flattened)dimensions of the pixel array */
  int dimension = modImage.width * modImage.height;
  modImage.loadPixels();
  for (int i = 0; i < dimension; i ++)
  {
    /* Gets the channelMode's channel value */
    int channelVal = getChannelValue(modImage.pixels[i]);
    
    /* Sets all of the channels to the value of the channelMode */
    modImage.pixels[i] = color(channelVal, channelVal, channelVal); 
  }
  /* Flushes out the above pixel images to the modImage object */
  modImage.updatePixels();
}

/* Simply grabs the r, g, or b channel from the current channelMode */
int getChannelValue(color pixelChannelValue)
{
  if (channelMode == 'r')
  {
    return (int)red(pixelChannelValue);
  }
  else if (channelMode == 'g')
  {
    return (int)green(pixelChannelValue);
  }
  else if (channelMode =='b')
  {
    return (int)blue(pixelChannelValue);
  }
  else
  {
    print("Error: Trying to set channel in a non r || g || b channelMode");
    return 0; 
  }
}

/* Loads a fresh copy of the image */
void resetModImage()
{
  modImage = loadImage("lab2.jpg");
  image(modImage, 0, 0);
}

/* Clears the modified image */
void clearModImage()
{
  modImage.width = 0;
  modImage.height = 0;
}
