/*--------------------------------------------------------------*/
/*--------------------------------------------------------------*/
/*--------------------------------------------------------------*/
/*--------------------------------------------------------------*/
//                  partie execution
/*--------------------------------------------------------------*/
/*--------------------------------------------------------------*/



final int nbR = 20;
final int nbV = 4;
final int nbP = 40 + nbR + nbV;
//ArrayList<IDisplaiyable> mListe = new ArrayList<IDisplaiyable>();
Env env = new Env();



void setup() {
  size(1280, 720);
  env.initialisation(nbP, nbR, nbV);

  //noLoop();
}

void draw() {

  background(238, 232, 141);
  env.nextStep();
  //keyPressed();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      Message tmp = env.m.getMessage(2, env.mListe.get(
          (int) random(env.mListe.size())).getP());
        env.mListe.add((IDisplaiyable)tmp);
        env.evenementiels.add(tmp);
    } else if (keyCode == DOWN) {
      for (int i = 0; i < env.mListe.size(); i++) {

        if (env.mListe.get(i).quelGenre() == 2) {
          ((Message)env.mListe.get(i)).setEvenement("mort", true);
        return;
      }
    }
    } 
  }
 }
