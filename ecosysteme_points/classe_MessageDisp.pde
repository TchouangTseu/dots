//classe enveloppe pour utiliser la fabrique dans la partie
//exécution
/*--------------------------------------------------------------*/
class MessageDisp extends Message implements IDisplaiyable {

  public MessageDisp(Point p) {
    super(p);
  }
  void move() {
  }
  void display() {
  }
  int quelGenre() { 
    return 14;
  }
}
