//renvoi une référence sur un message displaiyable instancié en 
//message rouge vert ou mort selon le context
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
