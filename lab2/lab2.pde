PImage baseImage;
PImage copyImage;

//Global char defining the current channel mode
char mode = 'a';
void setup()
{
  baseImage = loadImage("lab2.jpg");
  size(baseImage.width, baseImage.height);
}

void draw()
{
  background(255);
  image(baseImage, 0, 0);
  textSize(30);
  fill(0);
  color c = baseImage.get(mouseX, mouseY);
  r = (int)red(c);
  g = (int)green(c);
  b = (int)blue(c);
  
  text("RGB(" + r + ", " + g + ", " + b + ")", 10, 40);

  if (keyPressed) 
  {
    if (key == 'r' || key == 'R') 
    {
      pixels = getPixels();
    }
    else if (key == 'g' || key == 'G') 
    {
      pixels = getPixels();
    }
    else if (key == 'b' || key == 'B') 
    {
      pixels = getPixels();
    }
}

//void setup() {
//  size(100, 100);
//  tower = loadImage("tower.jpg");
//  int dimension = tower.width * tower.height;
//  tower.loadPixels();
//  for (int i = 0; i < dimension; i += 2) { 
//    tower.pixels[i] = color(0, 0, 0); 
//  } 
//  tower.updatePixels();
//}

void draw() {
  image(tower, 0, 0);
}

int[] getPixels()
{
  copyImage = baseImage.copy();
  return copyImage.pixels[];
}

void keyPressed()
{
}

