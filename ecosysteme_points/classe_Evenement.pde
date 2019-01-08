// les évenements sont récupérables par le système et permettent
//de transformer le porteur/emetteur
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
  public void setConsistant(boolean b) {
    consistant = b;
  }
}
