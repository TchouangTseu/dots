//--------------------------------------------------------------//
//--------------------------------------------------------------//
//--------------------------------------------------------------//
//


//un point  a une position, une vitesse, une façon de se déplacer,
//une façon de s'afficher et est sociable
//--------------------------------------------------------------//

class Point implements IDisplaiyable, ISociable {
  float x, y, vx, vy;
  ArrayList<IDisplaiyable> collegues;
  int rayon = 200;
  int id;


  Point(float x, float y, int id) {
    this.x = x;
    this.y = y;
    this.id = id;

    //float v =

    //jouer sur les valeurs vx et vy
    //même vitesse pour tous, vitesse
    //individualisée, ...
    this.vx = (random(id) - id/2)/10;
    this.vy = (random(id) - id/2)/10;

    this.collegues = new ArrayList<IDisplaiyable>();
  }

  Point makeRandomPoint(float x, float y, int id) {
    return new Point(random(x), random(y), id);
  }

  void move() { 

    vx += (random(2) -1)/11;
    vy += (random(2) -1)/11;

    float i = x + vx;
    float j = y + vy;

    if (i > width || i < 0) this.vx *=-1;
    if (j > height || j < 0) this.vy *= -1; 

    x += vx;

    y += vy;
  }

  float distance(Point p) {
    return dist(x, y, p.x, p.y);
  }

  void updateCollegues(ArrayList<IDisplaiyable> totalPoints) {
    this.collegues = new ArrayList<IDisplaiyable>();

    for (int i = 0; i < totalPoints.size(); i++) {
      //ce serait plus propre d'avoir une fonction 
      //boolean insideRayon(Point p)
      if (this.x - rayon < totalPoints.get(i).getX() &&
        this.x + rayon > totalPoints.get(i).getX() &&
        this.y - rayon < totalPoints.get(i).getY() &&
        this.y + rayon > totalPoints.get(i).getY()) {
        collegues.add(totalPoints.get(i)/*.getP()*/);
      }
    }
  }

  ArrayList<IDisplaiyable> getCollegues() {
    return this.collegues;
  }

  void setCollegues(ArrayList<IDisplaiyable> collegues) {
    this.collegues = collegues;
  }


  void drawConnection() {
    stroke(37, 51, 85, 75);
    strokeWeight(2);
    for (int i = 0; i < collegues.size(); i++) {
      line(x, y, collegues.get(i).getX(), 
        collegues.get(i).getY());
      /*collegues.remove(i);*/
    }
  }

  void display() {
    stroke(37, 51, 85);
    fill(37, 51, 85, 20);
    strokeWeight(8);
    ellipse(this.x, this.y, 8, 8);
  }
  boolean equals(Point p) {
    return id == p.id;
  }
  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  Point getP() {
    return this;
  }
  void transmit() {
  }
  void destroy() {
  }
  int quelGenre() {
    return 10/*"Point"*/;
  }
}
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
    print(" "+e.isConsistant());
    print(" "+e.getContenu());
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

public class Env {
  ArrayList<IDisplaiyable> mListe = new ArrayList<IDisplaiyable>();
  ArrayList<Evenement> eListe = new ArrayList<Evenement>();
  ArrayList<IEvenementiel> evenementiels = new ArrayList<IEvenementiel>();
  FabriqueMessage m = new FabriqueMessage();

  void initialisation(int nbPoints, int nbMessagesR, int nbMessagesV) {
    //p sert à créer des points à des positions
    //aléatoires.
    //à voir : faire de p une fabrique pour
    //         avoir des points qui ne portent
    //         pas de message
    Point p = new Point(width, height, -1);

    for (int i = 0; i < nbPoints; i++) {
      mListe.add(p.makeRandomPoint(width, height, i));
    }

    for (int i = 0; i < nbMessagesR; i++) {
      Message tmp = m.getMessage(2, mListe.get(
        (int) random(mListe.size())).getP());
      mListe.add((IDisplaiyable)tmp);
      evenementiels.add(tmp);
    }
    for (int i = 0; i < nbMessagesV; i++) {
      Message tmp = m.getMessage(1, mListe.get(
        (int) random(mListe.size())).getP());
      mListe.add((IDisplaiyable)tmp);
      evenementiels.add(tmp);
    }
  }

  void setEvenements(ArrayList<Evenement> e) {

    eListe = e;
  }

  void updateEvenements() {

    ArrayList<Evenement> tmp = new ArrayList<Evenement>();

    for (int i = 0; i < evenementiels.size(); i++) {
      
      if (evenementiels.get(i).hasEvenement()) {
        print("traitement signal " + i + " ");
        tmp.add(evenementiels.get(i).getEvenement());
      }
    }
    setEvenements(tmp);
  }

  void traiteEvenements() {
    for (int i = 0; i < eListe.size(); i++) {

      if (eListe.get(i).getContenu().equals("mort")) {

        for (int j = 0; j < mListe.size(); j++) {
          if (eListe.get(i).getEmetteur().equals(
            mListe.get(j))) {
            mListe.set(j, m.getMessage(3, 
              mListe.get(j).getP()));
          }
        }
      }
    }
  }

  void nextStep() {
    for (int i = 0; i < mListe.size(); i++) {
      mListe.get(i).move();
      mListe.get(i).updateCollegues(mListe);
      mListe.get(i).transmit();
      mListe.get(i).drawConnection();  
      mListe.get(i).display();
    }
    updateEvenements();
    traiteEvenements();
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



/*--------------------------------------------------------------*/
/*--------------------------------------------------------------*/
/*--------------------------------------------------------------*/
/*--------------------------------------------------------------*/
//                  partie execution
/*--------------------------------------------------------------*/
/*--------------------------------------------------------------*/



final int nbR = 3;
final int nbV = 5;
final int nbP = 10 + nbR + nbV;
//ArrayList<IDisplaiyable> mListe = new ArrayList<IDisplaiyable>();
Env env = new Env();



void setup() {
  size(1280, 720);
  env.initialisation(18, 3, 5);

  //noLoop();
}

void draw() {

  background(238, 232, 141);
  env.nextStep();
  /*for(int i = 0; i < mListe.size(); i++){
   mListe.get(i).move();
   mListe.get(i).updateCollegues(mListe);
   mListe.get(i).transmit();
   mListe.get(i).drawConnection();  
   mListe.get(i).display();
   }*/
}
