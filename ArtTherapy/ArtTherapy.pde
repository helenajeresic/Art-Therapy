PImage img;
PImage borderedImg;
int fillColor = color(255,255,255);   // Defaultna boja za bojanje
int numColors;
int colorWidth;          // Širina svakog kvadrata boje
int colorHeight;         // Visina svakog kvadrata boje
int padding;             // Prostor između svakog kvadrata boje
int startX;              // Početna x-koordinata trake s bojama
int startY;              // Početna y-koordinata trake s bojama
int numberInRow;         // Broj boja u traci

void setup() {
  background(#67177c);
  size(800, 650);
  img = loadImage("opcija2.png");
  
  // Stvori novu sliku za obrub
  borderedImg = createImage(img.width + 10, img.height + 10, ARGB);
  
  // Kopiraj originalnu sliku u središte nove slike
  borderedImg.copy(img, 0, 0, img.width, img.height, 5, 5, img.width, img.height);
  
  // Dodaj obrub na novu sliku
  borderedImg.loadPixels();
  for (int x = 0; x < borderedImg.width; x++) {
    for (int y = 0; y < 5; y++) {
      borderedImg.pixels[y * borderedImg.width + x] = color(#4cd728);
      borderedImg.pixels[(borderedImg.height - y - 1) * borderedImg.width + x] = color(#4cd728);
    }
  }
  for (int y = 0; y < borderedImg.height; y++) {
    for (int x = 0; x < 5; x++) {
      borderedImg.pixels[y * borderedImg.width + x] = color(#4cd728); 
      borderedImg.pixels[y * borderedImg.width + (borderedImg.width - x - 1)] = color(#4cd728);
    }
  }
  borderedImg.updatePixels();
  
  // Prikaz slike
  image(borderedImg, 0, 0);
  
  // Iscrtavanje trake s bojama
  numColors = 30;
  colorWidth = 30; 
  colorHeight = 30; 
  padding = 5;
  startX = 10; 
  startY = img.height + 20; 
  numberInRow = 15; 
  
  int rows = (int) Math.ceil((float) numColors / numberInRow);   
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < numberInRow; col++) {
      int index = row * numberInRow + col; 
      if (index < numColors) {
        int currentColor = getColor(index); 
        fill(currentColor); 
        stroke(currentColor); 
        rect(startX + (colorWidth + padding) * col, startY + (colorHeight + padding) * row, colorWidth, colorHeight); // Nacrtaj kvadrat boje
      }
    }
  }
}

int getColor(int index) {
  switch (index % numColors) {
    case 0:
      return color(178,34,34); 
    case 1:
      return color(220,20,60);
    case 2:
      return color(255,127,80);
    case 3:
      return color(250,128,114);
    case 4:
      return color(255,140,0);
    case 5:
      return color(255,215,0); 
    case 6:
      return color(238,232,170); 
    case 7:
      return color(128,128,0);
    case 8:
      return color(154,205,50);
    case 9:
      return color(173,255,47);
    case 10:
      return color(0,100,0);
    case 11:
      return color(144,238,144);
    case 12:
      return color(0,250,154);
    case 13:
      return color(32,178,170);
    case 14:
      return color(0,206,209);
    case 15:
      return color(100,149,237);
    case 16:
      return color(0,0,128);
    case 17:
      return color(135,206,235);
    case 18:
      return color(138,43,226); 
    case 19:
      return color(147,112,219);
    case 20:
      return color(186,85,211); 
    case 21:
      return color(238,130,238); 
    case 22:
      return color(199,21,133);
    case 23:
      return color(250,235,215);
    case 24:
      return color(222,184,135);
    case 25:
      return color(255,239,213); 
    case 26:
      return color(245,255,250);
    case 27:
      return color(169,169,169);
    case 28:
      return color(211,211,211);
    case 29:
      return color(255,255,255);
    default:
      return color(255,255,255); 
  }
}



void draw() {
  // Iscrtavanje kvadrata s trenutno odabranom bojom
  fill(fillColor);
  stroke(fillColor);
  rect(borderedImg.width - colorWidth * 2.5 , startY, colorWidth * 2, colorHeight * 2 + padding);
}

void mousePressed() {
  int x = mouseX;
  int y = mouseY;
  int startY = img.height + 20; // Početna y-koordinata trake s bojama
  
  // Provjeri da li je kliknuti piksel u traci s bojama
  if (y >= startY && y <= startY + colorHeight * 2 + padding) {
    // Provjeri koji kvadrat boje je kliknut
    int clickedIndex = -1;
    for (int i = 0; i < numColors; i++) {
      int startX = 10 + (colorWidth + padding) * (i % numberInRow); 
      if (x >= startX && x <= startX + colorWidth) {
        if(y >= startY && y <= startY + colorHeight) {
          clickedIndex = i;
        } else if (y >= startY + colorHeight + padding && y <= startY + colorHeight * 2 + padding) {
          clickedIndex = numberInRow + i;
        }
        break;
      }
    }
    
    if (clickedIndex != -1) {
      fillColor = getColor(clickedIndex);
    }
  } else if (x >= 5 && x < borderedImg.width - 5 && y >= 5 && y < borderedImg.height - 5) {
    int clickedColor = borderedImg.get(x, y);
    if (clickedColor != color(0)) {
      floodFill(x, y, fillColor);
      
      // Ponovno prikaži sliku s novim bojama
      image(borderedImg, 0, 0);
    }
  }
}

// Flood Fill algoritam
void floodFill(int x, int y, int fillColor) {
  int targetColor = borderedImg.get(x, y);
  if (fillColor == targetColor) return;

  ArrayList<PVector> stack = new ArrayList<PVector>();
  stack.add(new PVector(x, y));

  while (!stack.isEmpty()) {
    PVector current = stack.remove(stack.size() - 1);
    x = (int) current.x;
    y = (int) current.y;

    if (borderedImg.get(x, y) == targetColor) {
      borderedImg.set(x, y, fillColor);

      stack.add(new PVector(x - 1, y)); 
      stack.add(new PVector(x + 1, y));
      stack.add(new PVector(x, y - 1)); 
      stack.add(new PVector(x, y + 1)); 
    }
  }
}
