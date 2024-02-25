// Dohvati odabranu boju na paleti.
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

// Ažuriranje obojane slike.
void azuriraj(){
  image(borderedImg, 0, 0);
  image(decorImg, 0, 150);
  
  if(initialized == false){
    drawStaticElements();
    postaviPaletu();
  }
}

void Resetiraj(){
  size(800, 800);
  
  // Crtanje odabrane slike ili neke po defaultu.
  if(selectedImage != null) {
    img = loadImage(selectedImage);
  } else {
    img = loadImage("opcija10.png");
  }
  
  // Postavljanje slike olovke.
  olovka = loadImage("olovka.png");
  
  // Stvori novu sliku za obrub.
  borderedImg = createImage(img.width + 10, img.height + 10, ARGB);
  
  // Kopiraj originalnu sliku u središte nove slike.
  borderedImg.copy(img, 0, 0, img.width, img.height, 5, 5, img.width, img.height);
  
  // Dodaj obrub na novu sliku.
  borderedImg.loadPixels();
  for (int z = 0; z < borderedImg.width; z++) {
    for (int k = 0; k < 5; k++) {
      borderedImg.pixels[k * borderedImg.width + z] = color(#00008B);
      borderedImg.pixels[(borderedImg.height - k - 1) * borderedImg.width + z] = color(#00008B);
    }
  }
  for (int k = 0; k < borderedImg.height; k++) {
    for (int z = 0; z < 5; z++) {
      borderedImg.pixels[k * borderedImg.width + z] = color(#00008B); 
      borderedImg.pixels[k * borderedImg.width + (borderedImg.width - z - 1)] = color(#00008B);
    }
  }
  borderedImg.updatePixels();
  
  // Prikaz slike.
  image(borderedImg, 0, 0);
  
  // Crtanje gumbova desno i palete, ako već nisu nacrtani.
  if(initialized == false){
    drawStaticElements();
    postaviPaletu();
  }
}

// Flood Fill algoritam.
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
