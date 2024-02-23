import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.awt.FlowLayout;
import java.awt.Color;
import java.awt.Image;
import java.io.File;

String[] images = {"opcija1.png", "opcija2.png", "opcija3.png", "opcija4.png", "opcija5.png", "opcija6.png", 
                  "opcija7.png", "opcija8.png", "opcija9.png", "opcija10.png", "opcija11.png", "opcija12.png",
                "opcija13.png", "opcija14.png", "opcija15.png", "opcija16.png"};
String selectedImagePath;
JDialog dialog = new JDialog();

void ZaslonOdabirSlike() {
  dialog.setTitle("Select Image");
  dialog.setSize(800, 1000);
  dialog.setLocationRelativeTo(null);  
  dialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);

  JPanel panel = new JPanel(new FlowLayout(FlowLayout.CENTER, 10, 10));

  for (String imagePath : images) {
    // Load the image
    ImageIcon originalIcon = new ImageIcon(loadImage(imagePath).getImage());

    // Scale the image to your desired size
    Image scaledImage = originalIcon.getImage().getScaledInstance(150, 150, Image.SCALE_SMOOTH);

    // Create a new ImageIcon with the scaled image
    ImageIcon scaledIcon = new ImageIcon(scaledImage);

    JButton imageButton = new JButton(scaledIcon);
    imageButton.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        selectedImagePath = imagePath;
      }
    });
    panel.add(imageButton);
  }
  dialog.add(panel);
  
  JButton openFileButton = new JButton("Open File");
  openFileButton.addActionListener(new ActionListener() {
    @Override
    public void actionPerformed(ActionEvent e) {
      dialog.setEnabled(true);
      openFile();
    }
  });
  panel.add(openFileButton);

  JButton confirmButton = new JButton("Confirm");
  confirmButton.addActionListener(new ActionListener() {
    public void actionPerformed(ActionEvent e) {
      selectedImage = selectedImagePath;
      println(selectedImagePath);
      println(selectedImage);
      dialog.dispose();
      Resetiraj();
    }
  });
  panel.add(confirmButton);
  dialog.setVisible(true);
}

/*
void openFile() {
  JFileChooser fileChooser = new JFileChooser();
  String currentDir = System.getProperty("user.dir");
  fileChooser.setCurrentDirectory(new File(currentDir));
  FileNameExtensionFilter filter = new FileNameExtensionFilter("Image files", "png", "jpg", "jpeg", "gif");
  fileChooser.setFileFilter(filter);

  int returnValue = fileChooser.showOpenDialog(null);
  println("return value",returnValue);
  if (returnValue == JFileChooser.APPROVE_OPTION) {
    File selectedFile = fileChooser.getSelectedFile();
    println("selected file", selectedFile);
    selectedImage = selectedFile.getAbsolutePath();
    println("Selected Image: " + selectedImage);
  }
}
*/

void openFile() {
  selectInput("Select an image file", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    selectedImage = selection.getName();
    println(selectedImage);
    Resetiraj();
    dialog.dispose();
  }
}
