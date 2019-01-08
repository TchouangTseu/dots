//un point  a une position, une vitesse, une façon de se déplacer,
//une façon de s'afficher et est sociable
//peut être écrire des classes héritant de point
//--------------------------------------------------------------//

class Point implements IDisplaiyable, ISociable {
  float x, y, vx, vy;
  ArrayList<IDisplaiyable> collegues;
  int rayon = 120;
  int id;


  Point(float x, float y, int id) {
    this.x = x;
    this.y = y;
    this.id = id;

    //float v =

    //jouer sur les valeurs vx et vy
    //même vitesse pour tous, vitesse
    //individualisée, ...
    this.vx = (random(id) - id/2)/29;
    this.vy = (random(id) - id/2)/29;

    this.collegues = new ArrayList<IDisplaiyable>();
  }

  Point makeRandomPoint(float x, float y, int id) {
    return new Point(random(x), random(y), id);
  }

  void move() { 

    vx +=( (random(2) -1)/11)%2;
    vy += ((random(2) -1)/11)%2;

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
    stroke(37, 51, 85, 60);
    strokeWeight(2);
    for (int i = 0; i < collegues.size(); i++) {
      line(x, y, collegues.get(i).getX(), 
        collegues.get(i).getY());
    }
  }

  void display() {
    stroke(37, 51, 85);
    fill(37, 51, 85);
    strokeWeight(5);
    ellipse(this.x, this.y, 5, 5);
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
