//message rouge transformé par l'action d'un vert
//classe sous exploitée
/*--------------------------------------------------------------*/
class MessageMort extends MessageDisp {
  int t;
  int cpt;
  public MessageMort(Point p) {
    super(p);
    t = 15 + ((int) (random(7) - 3.5));
  }
  void display() {
    p.display();
    noStroke();
    fill(126, 43, 151, 50);
    ellipse(p.getX(), p.getY(), 50, 50);
    cpt++;
    if (cpt > t) {
      this.setEvenement("disparait", true);
      e.setEmetteur((IDisplaiyable)this);
    }
  }
  void move() {
  }
  int quelGenre() {
    return 3/*"MessageMort"*/;
  }
}
