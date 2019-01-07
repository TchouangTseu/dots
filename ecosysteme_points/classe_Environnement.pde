//classe environnement, gére le processus de création d'un nouvel
//état du système grâce à une liste sur tous les objets présents
//et un mécanisme de récupération et traitement des évenements
/*--------------------------------------------------------------*/

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
        tmp.add(evenementiels.get(i).getEvenement());
      }
    }
    setEvenements(tmp);
  }

  void traiteEvenements() {
    for (int i = 0; i < eListe.size(); i++) {

      if (eListe.get(i).getContenu().equals("mort")) {

        for (int j = 0; j < mListe.size(); j++) {
          if (eListe.get(i).getEmetteur().equals(mListe.get(j))) {
            Message tmp = m.getMessage(3, mListe.get(j).getP());
            mListe.set(j, (IDisplaiyable) tmp);
            evenementiels.add(tmp);
          }
        }
      }

      //peut etre améliorée sans trop d'effort avec des messageR 
      //qui apparaissent pres de leur parent
      if (eListe.get(i).getContenu().equals("multiplie")) { 
        Message tmp = m.getMessage(2, mListe.get(
          (int) random(mListe.size())).getP());
        mListe.add((IDisplaiyable)tmp);
        evenementiels.add(tmp);
        eListe.get(i).setConsistant(false);
      }

      if (eListe.get(i).getContenu().equals("disparait")) {
        mListe.remove(eListe.get(i).getEmetteur());
        evenementiels.remove(eListe.get(i).getEmetteur());
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
