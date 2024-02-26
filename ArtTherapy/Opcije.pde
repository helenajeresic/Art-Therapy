import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.awt.FlowLayout;
import java.awt.Color;
import java.awt.Image;
import java.io.File;

// Lista naziva slika koje se nude za bojanje u opcijama.
String[] images = {"opcija1.png", "opcija2.png", "opcija3.png", "opcija4.png", "opcija5.png", "opcija6.png", 
                  "opcija7.png", "opcija8.png", "opcija9.png", "opcija10.png", "opcija11.png", "opcija12.png",
                  "opcija13.png", "opcija15.png", "opcija18.png", "opcija20.png"};
String selectedImagePath;
JDialog dialog = new JDialog();

// Otvaranje i rad s zaslonom za odabir slike za bojanje. 
void ZaslonOdabirSlike() {
  enabled = false;
  // Otvaranje dijaloga.
  dialog.setTitle("Select Image");
  dialog.setSize(800, 800);
  dialog.setLocationRelativeTo(null);  
  dialog.setDefaultCloseOperation(JDialog.DO_NOTHING_ON_CLOSE);

  JPanel panel = new JPanel(new FlowLayout(FlowLayout.CENTER, 10, 10));

  for (String imagePath : images) {
    // Učitavanje slike.
    ImageIcon originalIcon = new ImageIcon(loadImage(imagePath).getImage());

    // Skaliranje učitanih slika.
    Image scaledImage = originalIcon.getImage().getScaledInstance(150, 150, Image.SCALE_SMOOTH);

    // Kreiranje ikona s trenutnom slikom.
    ImageIcon scaledIcon = new ImageIcon(scaledImage);

    // Gumbovi kojima pratimo odabranu sliku.
    JButton imageButton = new JButton(scaledIcon);
    imageButton.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        selectedImagePath = imagePath;
      }
    });
    panel.add(imageButton);
  }
  dialog.add(panel);
  
  // Gumb koji otvara dijalog za otvaranje slike.
  JButton openFileButton = new JButton("Open File");
  openFileButton.addActionListener(new ActionListener() {
    @Override
    public void actionPerformed(ActionEvent e) {
      dialog.setEnabled(true);
      openFile();
    }
  });
  panel.add(openFileButton);

  // Gumb kojim potvrđujemo odabranu opciju.
  JButton confirmButton = new JButton("Confirm");
  confirmButton.addActionListener(new ActionListener() {
    public void actionPerformed(ActionEvent e) {
      selectedImage = selectedImagePath;
      enabled = true;
      println(selectedImage);
      dialog.dispose();
      Resetiraj();
    }
  });
  panel.add(confirmButton);
  
  // Gumb kojim se izlazi iz opcija, ne mijenja odabranu sliku.
  JButton closeButton = new JButton("Close");
  closeButton.addActionListener(new ActionListener() {
    @Override
    public void actionPerformed(ActionEvent e) {
        System.out.println("Close button clicked");
        enabled = true;
        dialog.dispose();
    }
  });
  panel.add(closeButton);
  dialog.setVisible(true);
}

// Poziva selectInput funckiju koja otvara dijalog za odabir datoteke,
// nakon toga se poziva funckija "fileSelected".
void openFile() {
  selectInput("Select an image file", "fileSelected");
}

// Provjera odabrane datoteke i spremanje  globalnu varijablu.
void fileSelected(File selection) {
  // Provjerava je li korisnik odabrao datoteku ili zatvorio dijalog.
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    enabled = true;
    // Postavlja ime odabrane datoteke (samo ime, bez putanje) u varijablu selectedImage.
    selectedImage = selection.getName();
    println(selectedImage);
    
    // Poziva funkciju Resetiraj kako bi se prikazala nova slika.
    Resetiraj();
    
    // Zatvara dijalog za odabir datoteke.
    dialog.dispose();
  }
}
