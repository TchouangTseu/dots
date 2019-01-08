//les classes de la famille message ont
// - un point en support, les messages se déplaçant
//    de point en point
// - une liste de collegues parce que les messages sont
//   sociables
// - la capacité de générer des évenements
/*--------------------------------------------------------------*/

class Message implements ISociable, IEvenementiel {
  Point p;
  int latence = 0;
  int latMax = 10 + (int) random(20);
  int nbTransmit = 0;
  ArrayList<IDisplaiyable> collegues; 
  Evenement e;

  Message(Point p) {
    this.p = p; 
    this.e = new Evenement();
  }

  void setCollegues(ArrayList<IDisplaiyable> collegues) {
    this.collegues = collegues;
  }

  ArrayList<IDisplaiyable> getCollegues() {
    return this.collegues;
  }



  void transmit() {
    if (latence < latMax) {
      latence ++; 
      return;
    }
    latence = 0;
    if (p.collegues.size() == 0) return;
    this.p = p.collegues.get(
      (int) random(p.collegues.size())).getP();
    nbTransmit ++;//pour une future prolifération
  }



  void drawConnection() {
    /* ArrayList<IDisplaiyable> vide = null;
     this.setCollegues(vide);*/
  }

  void updateCollegues(ArrayList<IDisplaiyable> totalPoints) {
    //p.updateCollegues(totalPoints);
    this.collegues = p.getCollegues();
  }

  float getX() {
    return p.x;
  }

  float getY() {
    return p.y;
  }

  Point getP() { 
    return p;
  }

  int quelGenre() {
    return 0/*"Message"*/;
  }

  boolean hasEvenement() {
    //print(" "+e.isConsistant());
    //print(" "+e.getContenu());
    return e.isConsistant();
  }
  Evenement getEvenement() {
    return e;
  }
  void setEvenement(String contenu, boolean b) {
    e.contenu = contenu;
    e.consistant = b;
    e.emetteur = (IDisplaiyable) this;
  }
}
