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
