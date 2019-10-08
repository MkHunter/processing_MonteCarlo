import controlP5.*;
ControlP5 jControl;
boolean showPi = true, drawPi,drawBuffon;
//To aproximate Pi
int xI = 50, yI = 50, r = 200;
int n = 1;

Buffon b;

int insideC, nTotal;
PImage img, txt;
Chart myChart;

void setup() {
  frameRate(60);
  fullScreen();
  //size(1200, 600);
  
  img = loadImage("GatorSoft.png");
  img.resize(100, 100);
  txt = loadImage("Text.png"); //445 x 100
  txt.resize(65, 15);
  int d = 2*r;
  b = new Buffon(10,new Point(50,50),d,d);
  
  controllers();
  borders();
}

//  EVENT MANAGERS
void controllers(){
  PFont font = createFont("SansSerif.plain", 14);
  textFont(font);  //print(PFont.list());
  
  jControl = new ControlP5(this); // Creation of the controller

  jControl.addTextfield("Entrada")  //Creation of TextField
    .setMax(Integer.MAX_VALUE)       // Max int value
    .setInputFilter(1)               // Integer values only
    .setPosition(width/2-64, height/2)   // x,y Position
    .setSize(120, 30)                 // h,w
    .setFont(font)                   // Font is using
    .setFocus(true)                  // Get Focus when the program runs
    .setColor(color(255))            // Font color
    ;

  jControl.addToggle("Select")
    .setPosition((width-64)/2, height/3)
    .setSize(60, 30)
    .setValue(true)
    .setMode(ControlP5.SWITCH)
    ;
  myChart = jControl.addChart("dataflow").setColorBackground(color(0)) // Verde : 0,121,108 Amarillo: 240,182,6
    .setPosition(width/2+128, 50)
    .setSize(400, 400)
    .setRange(PI-.2, PI+.2)
    .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
    .setStrokeWeight(10)
    .setColorCaptionLabel(color(240, 182, 6))
    .setColorLabel(color(240, 182, 6));
  ;
}
  // Button
public void controlEvent(ControlEvent theEvent) {
  if (theEvent.getController() instanceof Toggle) {
    println(theEvent.getController().getName()+" showPi = "+showPi+" drawPi= "+drawPi + " drawBuffon"+drawBuffon);
  } else if (theEvent.getController() instanceof Textfield) {
    Textfield te = (Textfield) theEvent.getController();
    
    n = int(te.getText());
    nTotal = 1;
    insideC = 0;
        
    if(showPi){
        drawBuffon = false;
        drawPi = true;
    }else{
        b.reset();
        drawBuffon = true;
        drawPi = false;
    }
    println(theEvent.getController().getName()+" showPi = "+showPi+" drawPi= "+drawPi + " drawBuffon"+drawBuffon);
    myChart.addDataSet("incoming");
    myChart.setData("incoming", new float[500]);
    
    back();
    setdrawPi();

  }
}
  //Toggle
void Select(boolean theFlag) {
  //background(0);
  drawPi=false;
  drawBuffon = false;
  showPi=!theFlag;
  back();
  println("a Select event.");
}
// DRAWING METHODS
   //Generate Borders of the chart
void borders() {
  rectMode(0);
  stroke(240, 182, 6);
  rect(width/2+127, 49, 402, 402);
  line(width-80, 250, width-50, 250);
  textSize(28);
  text("π", width-40, 250);
}
  //Generate background using loops
void back() {
  background(0);
  fill(0);
  stroke(0, 121, 108, 85);
  for (int i =0; i<width; i+=50) {
    if (i>7*50)
      line(i, 0, i*4, height);
  }
  stroke(240, 182, 6, 85);
  for (int i = width; i>0; i-=50) {
    if (i>=7*50)
      line(i, height, i*4, 0);
  }
  noFill();
  noStroke();
}
//DRAW THE LOGO
  //Mid position
void drawLogo(){
  noFill();
  rectMode(0);
  stroke(0, 121, 108);
  rect(width/2-53, height/6-53, 103, 103, 10);
  //rect(width/2, height/6+42, 85, 100/6, 80);
  //imageMode(CENTER);
  Logo(img, width/2-50, height/6-50);
  //image(img, width/2-50, height/6-50, 100, 100);
  rectMode(CENTER);
  strokeWeight(2);
  fill(240, 182, 6);
  stroke(0, 121, 108);
  rect(width/2, height/6+42, 85, 100/6, 80);
  imageMode(PImage.CENTER);
  image(txt, width/2, height/6+42);
  fill(0);
}
  //Constantly draw it at certain rate:
  int controlRate = 50;
void Logo(PImage img, int inX, int inY) {
  for (int i = 0; i < controlRate; i++) {
    float x = random(0, 100);
    float y = random(0, 100);
    color c = img.get(int(x), int(y));
    fill(c, 97);
    noStroke();
    ellipse(int(inX)+x, int(inY)+y, 4, 4);
    fill(255);
  }
}
//DRAW THE TEMPLATE OF...
  // Aproximate the value of Pi with the circumference of a circle
  // given a random set of points (x,y)
void setdrawPi() {
  //translate(r, r);
   stroke(240, 182, 6);
   strokeWeight(1);
   noFill();
   rectMode(CENTER);
   rect(xI+r, yI+r, r*2, r*2);
  if (showPi) {
      ellipse(xI+r, yI+r, r*2, r*2);
  } else {
      drawVerticals();
  }
  borders();
  stroke(255);
  textSize(26);
  fill(255);
  text("π", width-40, 250);
  noFill();
  //translate(-r,-r);
}
  // Aproximate the value of Pi with the circumference of a circle
  // given a random set of points (x,y)
void drawVerticals(){
  int d = r*2; //Diameter
  strokeWeight(1);
  for(int i = 50; i<d+50;i +=d/10 ){ // i < w - x ?
    line(i,50,i,d+50);
  }
}

void draw() {
  setdrawPi(); 
  if (drawPi) 
    drawAproxPi();
  if(drawBuffon)
    drawBuffon();

  //rectMode(CENTER);
  drawLogo();
}

//                                           2nd Homework... aproximate the value of PI
float aproxPi;

void drawAproxPi() {
  int transX = xI+r, transY = yI+r;
  //translate(xI+r, yI+r);
  float x=0;
  float y=0;
  float d=0;
  for (int i = 0; i<1000; i++) { //i<(int)(Math.log((double)n)-1)
    if (nTotal <= n) {
      x = random(-r+transX, r+transY);
      y = random(-r+transX, r+transY);
      d = dist(transX, transY, x, y);
      if (d <= r) {
        insideC++;
        stroke(37, 165, 155, 80);
      } else {
        stroke(206, 5, 7, 80);
      }
      strokeWeight(3);
      point(x, y);
      aproxPi = 4*float(insideC)/float(nTotal);
      myChart.push(aproxPi);
      nTotal++;
    }
  }

  fill(0);
  stroke(240, 182, 6);
  rectMode(0);
  rect(transX-r, transY+r+yI, r*2, yI);
  
  println(transX-r+","+transY+r+yI+","+ r*2+","+ yI);
  
  fill(255);
  //aproxPi = 4*float(insideC)/float(nTotal);
  text("Valor aprox.("+insideC+"/"+(nTotal-1)+") : ", 13+transX-r, transY+r+yI+25);
  text(str(aproxPi), 13+transX-r/2, transY+r+yI*2);
}

void drawBuffon() {
  for (int i = 0; i<1000; i++) { //i<(int)(Math.log((double)n)-1)
        if (nTotal <= n) {
            b.display();
            aproxPi = 2*float(nTotal)/float((b.nSuccess==0?1:b.nSuccess))-float(85)/float(1000);
            myChart.push(aproxPi);
            nTotal++;
        }else{break;}
    }

  fill(0);
  stroke(240, 182, 6);
  rectMode(0);
  rect(50, 500, 400, 50);
  fill(255);
  //aproxPi = 4*float(insideC)/float(nTotal);
  text("Valor aprox.("+(nTotal-1)+"/"+b.nSuccess+") : ", 63, 525);
  text(str(aproxPi), 13+50, 550);
}