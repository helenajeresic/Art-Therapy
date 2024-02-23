import javax.swing.JOptionPane;
import processing.pdf.*;

PImage cropImg;
PImage ikona;
PImage img;
PImage borderedImg;
PImage decorImg;
PImage olovka;
PImage pozadina;
PImage gumica;
PImage disketa;
PImage printer;
PImage ploca;
PGraphics pg;
int olovkaSize = 50; // Veličina olovke
float olovkaX, olovkaY; // Trenutni položaj olovke
int fillColor = color(255,255,255);   // Defaultna boja za bojanje
int numColors;
int colorWidth;          // Širina svakog kvadrata boje
int colorHeight;         // Visina svakog kvadrata boje
int padding;             // Prostor između svakog kvadrata boje
int startX;              // Početna x-koordinata trake s bojama
int startY;              // Početna y-koordinata trake s bojama
int numberInRow;         // Broj boja u traci
String selectedImage;    // Odabrana slika u opcijama
boolean initialized = false;


void setup() {
  size(800, 800);
  ikona = loadImage("ikonica1.png");

  surface.setIcon(ikona);
  
  Resetiraj();
  initialized = true;
}

void postaviPaletu(){
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

void azuriraj(){
  //image(pozadina, 0, 0);
  image(borderedImg, 0, 0);
  image(decorImg, 0, 150);
  
  postaviPaletu();
  
  if(initialized == false){
    drawStaticElements();
    initialized = true;
  }
}


void draw() {
  azuriraj();
  // Ažuriraj položaj olovke na trenutni položaj miša
  
  olovkaX = mouseX;
  olovkaY = mouseY;

  // Prikazi sliku olovke na trenutnom položaju miša, ako je miš unutar slike za bojanje
  if(olovkaX <= 600 && olovkaY <= 544) {
    image(olovka, olovkaX - olovkaSize/2 +10 , olovkaY -olovkaSize/2-15 , olovkaSize, olovkaSize);
    noCursor();
  } else {
    cursor();
  }

  // Iscrtavanje kvadrata s trenutno odabranom bojom
  fill(fillColor);
  noStroke();
  
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
  
  // Provjeri je li kliknuti piksel unutar područja gdje se nalazi gumica
  if (mouseX >= width - 150 && mouseX <= width - 50 && mouseY >= 50 && mouseY <= 150) {
    Resetiraj();
  }
  
  //Provjeri je li klikunti piksel unuar područja gdje se nalazi disketa
  if (mouseX >= width-150 && mouseX <= width -50 && mouseY >= 250 && mouseY <= 350)
      {
        String  korisnickiUnos = JOptionPane.showInputDialog(null,"Unesite naziv datoteke za spremanje:", "Spremi", JOptionPane.PLAIN_MESSAGE);
        // Postavlja željene dimenzije PGraphics objekta
        int pgWidth = 615;
        int pgHeight = 544;
        
        // Kreira PGraphics objekt sa željenim dimenzijama
        pg = createGraphics(pgWidth, pgHeight);
        
        // Postavlja PGraphics tako da ne pokriva ceo ekran
        int offsetX = 5;
        int offsetY = 5;
        
        // Postavlja PGraphics kao trenutni kontekst sa određenim offsetom
        beginRecord(pg);
        pg.image(get(), -offsetX, -offsetY);
        endRecord();
        
        if(korisnickiUnos == null){
          
        }
        else{
        // Čuva PGraphics kao sliku
        pg.save(korisnickiUnos +".png");
        // Prikazuje poruku o uspešnom unosu
        JOptionPane.showMessageDialog(null, "Uspješno spremljeno!", "Uspjeh",JOptionPane.PLAIN_MESSAGE );
        }
 
      }
      
   // Provjeri je li kliknuti piksel unutar područja na kojem se nalazi ploča
   if(mouseX >= width - 150 && mouseY <= width-50 && mouseY >= 450 && mouseY <= 500) {
     ZaslonOdabirSlike();
   }
   
   //Provjeri je li kliknuti piksel unuat područja gdje se nalazi printer
   if (mouseX >= width-150 && mouseX <= width -50 && mouseY >= 600 && mouseY <= 700)
     {
       String  korisnickiUnos = JOptionPane.showInputDialog(null,"Unesite naziv datoteke za spremanje:", "Spremi", JOptionPane.PLAIN_MESSAGE);
       if(korisnickiUnos == null){
          
        }
        else{
        // Čuva PGraphics kao sliku
        beginRecord(PDF, korisnickiUnos +".pdf");
        cropImg = createImage(borderedImg.width - 5, borderedImg.height - 5, ARGB);
        cropImg.copy(borderedImg, 5, 5, borderedImg.width, borderedImg.height, 0, 0, borderedImg.width, borderedImg.height);
        image(cropImg, 0, 0);

        endRecord();
        JOptionPane.showMessageDialog(null, "Uspješno spremljeno!", "Uspjeh",JOptionPane.PLAIN_MESSAGE );
        azuriraj();
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

void Resetiraj(){
  background(#67177c);
  size(800, 800);
  
  if(selectedImage != null) {
    img = loadImage(selectedImage);
  } else {
    img = loadImage("opcija6.png");
  }
  
  //postavlja polozaj olovke 
  olovka = loadImage("olovka.png");
  
  // Stvori novu sliku za obrub
  borderedImg = createImage(img.width + 10, img.height + 10, ARGB);
  
  // Kopiraj originalnu sliku u središte nove slike
  borderedImg.copy(img, 0, 0, img.width, img.height, 5, 5, img.width, img.height);
  
  // Dodaj obrub na novu sliku
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
  
  postaviPaletu();
  
  decorImg = loadImage("bojice.png");
  decorImg.resize(0, 800);
  decorImg = decorImg.get(110, 0, decorImg.width, decorImg.height);
  // Prikaz slike bojice ispod trake s bojama
  image(decorImg, 0, 150);
  
  drawStaticElements();
}

// Crta opcije na desnoj strani
void drawStaticElements() {
  
  pozadina = loadImage("zvij.jpg");
  image(pozadina, 0, 0);
  //noCursor();
  crtajKrug(width-100, 100, 130);
  gumica = loadImage("gumica.png");
  image(gumica, width - 150, 50, 100, 100);
  
  crtajKrug(width-100, 300, 130);
  disketa = loadImage("disk.png");
  image(disketa, width-150, 250, 100, 100);
  
  crtajKrug(width-100, 650, 130);
  printer = loadImage("printer1.png");
  image(printer, width-150, 600, 100, 100);
  
  crtajKrug(width-100, 450, 130);
  ploca = loadImage("ploca.png");
  image(ploca, width-150, 400, 100, 100);
}

//crta krug oko opcije, samo da ima neku pozadinu i bolje se istice
void crtajKrug(float x_,float y_,float d_){
  stroke(#EDE9E8 ); // Postavljanje boje obruba na crnu
  fill(#EDE9E8 ); // Postavljanje boje ispune na neku nijansu plave

  float x = x_; // Središte kruga na polovici širine prozora
  float y = y_; // Središte kruga na polovici visine prozora
  float diameter = d_; // Promjer kruga

  ellipse(x, y, diameter, diameter); // Crtanje kruga
}
