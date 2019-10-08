class PieChart {
  float[] angles;
  int[] frecs;
  float diameter = 200;
  color[] c = {color(20,135,200),color(235,25,100),color(100,190,135),color(160,85,160)};
  PieChart(){
    angles = new float[4];
  }

  void display() {
    noStroke();
    fill(28, 112, 34);
    textSize(32);
    rect(width/6+diameter/2+12,(height+diameter)/16,300,diameter);  //Cuadrado de fondo verde, dibujado por ciertas razones...
    
    float lastAngle = 0;
    for (int i = 0; i < angles.length; i++) {
      fill(c[i]);
      arc(width/6, height/6, diameter, diameter, lastAngle, lastAngle+radians(angles[i]));
      lastAngle += radians(angles[i]);
      text("Jugador "+(i+1)+" : "+frecs[i], width/6+diameter/2+12, height/16+(i+1)*diameter/4);
    }
  }
  
  void setAngles(int [] frecuency){
    frecs = frecuency;
    int h = 0;
    for(int i = 0 ; i< frecuency.length;i++)
        h+=frecuency[i];
    for(int i = 0 ; i< frecuency.length;i++)
      angles[i] = map(frecuency[i],0,h,0,360);
  }
  
  void resetAngles(){
   for(int i = 0 ; i< angles.length;i++)
      angles[i] = 20*i;
  }
}