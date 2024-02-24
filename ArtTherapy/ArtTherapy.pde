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
int olovkaSize = 50;          // Veličina olovke
float olovkaX, olovkaY;       // Trenutni položaj olovke
int fillColor = color(255,255,255);   // Defaultna boja za bojanje
int numColors;
int colorWidth;               // Širina svakog kvadrata boje
int colorHeight;              // Visina svakog kvadrata boje
int padding;                  // Prostor između svakog kvadrata boje
int startX;                   // Početna x-koordinata trake s bojama
int startY;                   // Početna y-koordinata trake s bojama
int numberInRow;              // Broj boja u traci
String selectedImage;         // Odabrana slika u opcijama
boolean initialized = false;  // Inicijalizirana početna bojanka
boolean enabled = true;       // Omogućen rad s bojankom

void setup() {
  size(800, 800);
  ikona = loadImage("ikonica1.png");

  surface.setIcon(ikona);
  
  Resetiraj();
}


void draw() {
  
  if(enabled == true){
    // Ažuriranje slike koju bojamo.
    azuriraj();
  
    // Ažuriraj položaj olovke na trenutni položaj miša.
    olovkaX = mouseX;
    olovkaY = mouseY;

    // Ako je miš unutar slike za bojanje, prikaži sliku olovke na trenutnom položaju miša.
    // Inače prikaži cursor miša.
    if(olovkaX <= 600 && olovkaY <= 544) {
      image(olovka, olovkaX - olovkaSize/2 +10 , olovkaY -olovkaSize/2-15 , olovkaSize, olovkaSize);
      noCursor();
    } else {
      cursor();
    }  

    // Iscrtavanje kvadrata s trenutno odabranom bojom.
    fill(fillColor);
    noStroke();
  
    rect(borderedImg.width - colorWidth * 2.5 , startY, colorWidth * 2, colorHeight * 2 + padding);
  }
  /*
  // Ažuriranje slike koju bojamo.
  azuriraj();
  
  // Ažuriraj položaj olovke na trenutni položaj miša.
  olovkaX = mouseX;
  olovkaY = mouseY;

  // Ako je miš unutar slike za bojanje, prikaži sliku olovke na trenutnom položaju miša.
  // Inače prikaži cursor miša.
  if(olovkaX <= 600 && olovkaY <= 544) {
    image(olovka, olovkaX - olovkaSize/2 +10 , olovkaY -olovkaSize/2-15 , olovkaSize, olovkaSize);
    noCursor();
  } else {
    cursor();
  }

  // Iscrtavanje kvadrata s trenutno odabranom bojom.
  fill(fillColor);
  noStroke();
  
  rect(borderedImg.width - colorWidth * 2.5 , startY, colorWidth * 2, colorHeight * 2 + padding);
  */
}
