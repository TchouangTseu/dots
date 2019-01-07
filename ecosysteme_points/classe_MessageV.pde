//tue les messages rouge
//j'aimerais écrire un mécanisme de vieillissement, périodiquement
//la couleur s'assombrirait jusqu'à disparaitre pour réapparaitre
//en un nouveau message vert-jeune aléatoire
/*--------------------------------------------------------------*/
class MessageV extends MessageDisp /*implements IDisplaiyable*/ {

  public MessageV(Point p) {
    super(p);
  }

  void display() {
    p.display();
    noStroke();
    fill(18, 173, 43, 90);
    ellipse(p.getX(), p.getY(), 40, 40);
  }
  MessageDisp kill(MessageDisp m, Point p) {

    m = new FabriqueMessage().getMessage(3, p);
    return m;
  }
  void transmit() {

    for (int i = 0; i < getCollegues().size(); i++) {

      if (getCollegues().get(i).quelGenre() == 2) {
        //print("debug "+i+" genre collegue "+getCollegues().get(i).quelGenre()+" ");
        /* getCollegues().set(i, 
         kill((MessageDisp) getCollegues().get(i), 
         getCollegues().get(i).getP()));*/
        ((Message)getCollegues().get(i)).setEvenement("mort", true);/*.setContenu("mort");*/
        //((Message)getCollegues().get(i)).getEvenement().setConsistant(true);
        print(" "+((Message)getCollegues().get(i)).getEvenement().getContenu());
        return;
      }
    }
  }

  int quelGenre() {
    return 1/*"MessageV"*/;
  }

  void move() {
    p.vx = p.vx + (random(2) -1)/10;
    p.vy = p.vy + (random(2) -1)/10;

    float i = p.x + p.vx;
    float j = p.y + p.vy;

    if (i > width || i < 0) p.vx *=-1;
    if (j > height || j < 0) p.vy *= -1; 

    p.x += p.vx;

    p.y += p.vy;
  }
}
