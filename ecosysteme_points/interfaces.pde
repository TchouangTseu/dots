/*--------------------------------------------------------------*/
/*--------------------------------------------------------------*/
//                partie interfaces

public interface ISociable {
  ArrayList<IDisplaiyable> getCollegues();
  void setCollegues(ArrayList<IDisplaiyable> collegues);
  void updateCollegues(ArrayList<IDisplaiyable> collegues);
}

public interface IDisplaiyable extends ISociable {
  void display();
  void move();

  void drawConnection();
  void transmit();
  float getX();            /*interface un peu degueu, trop de trucs*/
  float getY();            /*à gerer*/
  Point getP();
  //introspection maison
  int quelGenre();
}

public interface IEvenementiel {
  boolean hasEvenement();
  Evenement getEvenement();
}
