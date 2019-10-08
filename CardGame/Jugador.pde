class Jugador {
  PImage img,def;
  int id = 0;
  int nVic = 0;
  color[] c = {color(20,135,200),color(235,25,100),color(100,190,135),color(160,85,160)};
  Jugador(int  id) { //id 0->4
    this.id = id;
    def = loadImage("def.png");
  }

  void setImage(PImage img) {
    this.img = img;
  }
  
  void setDefaultImage(){
    img = def;
  }

  void setId(int id) {
    this.id = id;
    
  }
  
  void display() {
      textSize(32);
    fill(c[id]);
    if (id % 2 == 0) { 
      text("Jugador "+(id+1), width/2, height/4*(id+1)-146);
      image((PImage)img, width/2, height/4*(id+1), 160, 246);
    } else {
      text("Jugador "+(id+1), width/4*id, height/2-146);
      image(img, width/4*id, height/2, 160, 246);
    }
  }
}