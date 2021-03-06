//tue les messages rouge
//j'aimerais écrire un mécanisme de vieillissement, périodiquement
//la couleur s'assombrirait jusqu'à disparaitre pour réapparaitre
//en un nouveau message vert-jeune aléatoire
/*--------------------------------------------------------------*/
class MessageV extends MessageDisp{

  public MessageV(Point p) {
    super(p);
  }

  void display() {
    //p.display();
    stroke(18, 173, 43);
    strokeWeight(2);
    fill(18, 173, 43, 90);
    ellipse(p.getX(), p.getY(), 50, 50);
  }
  MessageDisp kill(MessageDisp m, Point p) {

    m = new FabriqueMessage().getMessage(3, p);
    return m;
  }
  void transmit() {

    for (int i = 0; i < getCollegues().size(); i++) {

      if (getCollegues().get(i).quelGenre() == 2) {
        ((Message)getCollegues().get(i)).setEvenement("mort", true);
        return;
      }
    }
  }

  int quelGenre() {
    return 1/*"MessageV"*/;
  }

  void move() {
    p.vx = (p.vx + (random(2) -1)/17)%2;
    p.vy = (p.vy + (random(2) -1)/17)%2;

    float i = p.x + p.vx;
    float j = p.y + p.vy;

    if (i > width || i < 0) p.vx *=-1;
    if (j > height || j < 0) p.vy *= -1; 

    p.x += p.vx;

    p.y += p.vy;
  }
}
