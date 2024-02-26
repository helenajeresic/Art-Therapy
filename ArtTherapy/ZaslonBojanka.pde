// Postavlja paletu boja.
void postaviPaletu(){
  
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

// Crta krug oko opcije, samo da ima neku pozadinu i bolje se istice.
void crtajKrug(float x_,float y_,float d_){
  stroke(#EDE9E8 ); // Postavljanje boje obruba na crnu
  fill(#EDE9E8 ); // Postavljanje boje ispune na neku nijansu plave

  float x = x_; // Središte kruga na polovici širine prozora
  float y = y_; // Središte kruga na polovici visine prozora
  float diameter = d_; // Promjer kruga

  ellipse(x, y, diameter, diameter); // Crtanje kruga
}

// Crta opcija desno - brisanje obojanog, save (kao slika), save (kao pdf) i otvaranje opcija.
void drawStaticElements() {
 
  // Crtanje opcija.
  pozadina = loadImage("zvij.jpg");
  image(pozadina, 0, 0);
  
  // Crtanje kruga oko slike, opcija brisanja.
  crtajKrug(width-100, 100, 130);
  gumica = loadImage("gumica.png");
  image(gumica, width - 150, 50, 100, 100);
  
  // Opcija spremanja slike.
  crtajKrug(width-100, 280, 130);
  disketa = loadImage("disk.png");
  image(disketa, width-150, 230, 100, 100);
  
  // Otvaranje zaslona za biranje slike.
  crtajKrug(width-100, 470, 130);
  ploca = loadImage("ploca.png");
  image(ploca, width-135, 430, 80, 80);
  
  // Printanje slike.
  crtajKrug(width-100, 650, 130);
  printer = loadImage("printer1.png");
  image(printer, width-150, 600, 100, 100);
  
  decorImg = loadImage("bojice.png");
  decorImg.resize(0, 800);
  decorImg = decorImg.get(110, 0, decorImg.width, decorImg.height);
  // Prikaz slike bojice ispod trake s bojama
  image(decorImg, 0, 150);
  
  initialized = true;
}
