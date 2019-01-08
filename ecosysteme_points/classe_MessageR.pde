//message rouge
//accelre le déplacement du point qui l'héberge et se multiplie
/*--------------------------------------------------------------*/
class MessageR extends MessageDisp{
  int limitToMultiply;
  public MessageR(Point p) {
    super(p);
    limitToMultiply = 7 + ((int) random(5 - 2.5));
  }
  void display() {
    //p.display();
    stroke(195, 12, 62);
    strokeWeight(2);
    fill(195, 12, 62, 90); //couleur hardcoded, ça pue mais
    //l'association couleur/comportement
    //me permet de faire l'économie d'une 
    //implémentation spécifique des comportements
    //qui est à la place réalisée par héritage de
    //la classe message
    ellipse(p.getX(), p.getY(), 50, 50);
  }
  void move() {
    p.vx = (p.vx + (random(2) -1)/29)%2;
    p.vy = (p.vy + (random(2) -1)/29)%2;

    float i = p.x + p.vx;
    float j = p.y + p.vy;

    if (i > width || i < 0) p.vx *=-1;
    if (j > height || j < 0) p.vy *= -1; 

    p.x += p.vx;

    p.y += p.vy;
  }

  void transmit() {
    super.transmit();
    if (nbTransmit > limitToMultiply) {
      this.setEvenement("multiplie", true);
      nbTransmit = 0; 
    }
  }

  int quelGenre() {
    return 2 /*"MessageR"*/;
  }
}
