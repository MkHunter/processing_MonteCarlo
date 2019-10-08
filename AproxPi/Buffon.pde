import java.awt.Point;
class Buffon{
  int d,w,h;
  Point origin;
  
  int nSuccess;
  
  Buffon(int d,Point o,int w, int h){ //Número de datos a introducir y distancia entre las verticales
    this.d = d;
    this.w = w;
    this.h = h;
    this. origin = o;
  }
  
  void reset(){
     cont = 1;
     nSuccess = 0;
  }
  
  int cont = 1;
  void display(){
      strokeWeight(1);
      genNeedles();
      //dispNeedles();
  }
  
  void verticals(){
    for(float i = origin.x; i<w+origin.x;i += float(w/d)){ // i < w - x ?
      line(i,origin.y,i,h+origin.y);
    }
  }
  
  void genNeedles(){
    Point finish, start;
    float dx,dy;
    float dis = w/d;
    do{
      float theta = random(0,90);
      float x = random(origin.x,w+origin.x);
      float y = random(origin.y,h + origin.y);
      dx = x+cos(radians(theta))*dis;
      dy = y+ sin(radians(theta))*dis;
      start = new Point(int(x), int(y));
      finish = new Point(int(dx),int(dy));
    }while(finish.y <= origin.y || finish.x > origin.x+w || finish.y > origin.y+h);
      if(isCrossingLine(start, finish)){
          stroke(213,0,0);
      }else{
          stroke(0,121,108);
      }
      line(start.x,start.y,finish.x,finish.y);
    cont++;
  }
  
  boolean isCrossingLine(Point start, Point finish){
    for(float i = origin.x; i<w+origin.x;i += float(w/d))
      if((start.x < i && finish.x >= i) || (finish.x <= i && start.x > i)){
         nSuccess++;
         return true;
      }
      return false;
  }
}