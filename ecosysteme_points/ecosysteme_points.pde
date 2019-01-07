
//les classes de la famille message ont
// - un point en support, les messages se déplaçant
//    de point en point
// - une liste de collegues parce que les messages sont
//   sociables
// - ...
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
  void setEvenement(String contenu, boolean b){
    e.contenu = contenu;
    e.consistant = b;
  }
}


/*--------------------------------------------------------------*/
class FabriqueMessage {
  //1 pour vert, 2 pour rouge, 3 pour mort
  MessageDisp getMessage(int s, Point p) {
    MessageDisp res ;
    switch (s) {
      case 1/*"vert"*/: 
      res = new MessageV(p); 
      break;
      case 2/*"rouge"*/: 
      res = new MessageR(p); 
      break;
      case 3/*"mort"*/:  
      res = new MessageMort(p); 
      break;
    default : 
      res = null;
    }
    return res;
  }
}

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

//message rouge 
/*--------------------------------------------------------------*/
class MessageR extends MessageDisp /*implements IDisplaiyable*/ {
  public MessageR(Point p) {
    super(p);
  }
  void display() {
    p.display();
    noStroke();
    fill(195, 12, 62, 90); //couleur hardcoded, ça pue mais
    //l'association couleur/comportement
    //me permet de faire l'économie d'une 
    //implémentation spécifique des comportements
    //qui est à la place réalisée par héritage de
    //la classe message
    ellipse(p.getX(), p.getY(), 40, 40);
  }
  void move() {
    p.vx = p.vx + (random(2) -1)/29;
    p.vy = p.vy + (random(2) -1)/29;

    float i = p.x + p.vx;
    float j = p.y + p.vy;

    if (i > width || i < 0) p.vx *=-1;
    if (j > height || j < 0) p.vy *= -1; 

    p.x += p.vx;

    p.y += p.vy;
  }
  int quelGenre() {
    return 2 /*"MessageR"*/;
  }
}

/*--------------------------------------------------------------*/
class MessageMort extends MessageDisp /*implements IDisplaiyable*/ {
  public MessageMort(Point p) {
    super(p);
  }
  void display() {
  }
  void move() {
  }
  int quelGenre() {
    return 3/*"MessageMort"*/;
  }
}
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
        getCollegues().set(i, 
          kill((MessageDisp) getCollegues().get(i), 
          getCollegues().get(i).getP()));
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
    p.vx = p.vx + (random(1) -0.5)/10;
    p.vy = p.vy + (random(1) -0.5)/10;

    float i = p.x + p.vx;
    float j = p.y + p.vy;

    if (i > width || i < 0) p.vx *=-1;
    if (j > height || j < 0) p.vy *= -1; 

    p.x += p.vx;

    p.y += p.vy;
  }
}





/*--------------------------------------------------------------*/
class Evenement {
  IDisplaiyable emetteur;
  String contenu;
  boolean consistant ;

  public Evenement() {
    emetteur = null;
    contenu = null;
    consistant = false;
  }
  public void setContenu(String m) {
    contenu = m;
    consistant = true;
    //print("debug ");
  }
  public String getContenu() {
    return contenu;
  }
  public void setEmetteur(IDisplaiyable d) {
    emetteur = d;
  }
  public IDisplaiyable getEmetteur() {
    return emetteur;
  }
  public boolean isConsistant() {
    return consistant;
  }
  public void setConsistant(boolean b){
    consistant = b;
  }
}




/*--------------------------------------------------------------*/
/*--------------------------------------------------------------*/
/*--------------------------------------------------------------*/
/*--------------------------------------------------------------*/
//                  partie execution
/*--------------------------------------------------------------*/
/*--------------------------------------------------------------*/



final int nbR = 15;
final int nbV = 5;
final int nbP = 15 + nbR + nbV;
//ArrayList<IDisplaiyable> mListe = new ArrayList<IDisplaiyable>();
Env env = new Env();



void setup() {
  size(1280, 720);
  env.initialisation(nbP, nbR, nbV);
}

void draw() {

  background(238, 232, 141);
  env.nextStep();
}
