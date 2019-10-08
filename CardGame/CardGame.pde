import controlP5.*;
import java.util.*;

ControlP5 jControl;      // Controlador de Componentes
boolean corre;           // Variable booleana controladora de animación

boolean[][] cartastomadas;  // Matríz booleana de cartas que han sido tomadas a lo largo del juego...
int n;                   // Número de Juegos a realizar
PImage [][] cartas;      // Matríz de cartas

int [] frecuencias;      // Vector de frecuencias de victorias po juego
PieChart pie;            // Gráfica de pastel
Jugador [] jugadores;    // Vector de jugadores

void settings() {
  fullScreen();  //size(1600, 900);
}

void setup() {
  frameRate(60);                      // Controla la velocidad de la animación...
  cartas = getArregloImagenes();

  inicializarV();

  textSize(32);
  imageMode(CENTER);

  PFont font = createFont("SansSerif.plain", 14);
  textFont(font); 
  //Controlador
  jControl = new ControlP5(this);          // Creation of the controller

  jControl.addTextfield("Entrada")         //Creation of TextField
    .setMax(Integer.MAX_VALUE)             // Max int value
    .setInputFilter(1)                     // Integer values only
    .setPosition(width/2-60, height/2-15)  // x,y Position
    .setSize(120, 30)                      // h,w
    .setFont(font)                         // Font is using
    .setFocus(true)                        // Get Focus when the program runs
    .setColor(color(255))                  // Font color
    ;
}

public void controlEvent(ControlEvent theEvent) {            // Oyente del controlador
  if (theEvent.getController() instanceof Textfield) {       // Si es el TextField...
    Textfield te = (Textfield) theEvent.getController();

    n = int(te.getText());                                   //Se asigna el valor del texto a la variable n

    println("\n---------- Nuevo cálculo: n = "+n+" ----------\n");
    inicializarV();
    pie.resetAngles();
    corre = true;
    i = 0; 
    j =0; 
    h = 0; 
    fc = 0; 
    r = 0; 
    c = 0;      
    juegGanados = new int[4];
    lanzGanados = new int[4];//Estado inicial del juego
    frameCount = 0;
  }
}

void inicializarV() {                   // Inicializa algunas variables al realizar al utilizar el TextBox
  background(28, 112, 34);              // Fondo verde
  cartastomadas = new boolean [4][10];  // Matríz booleana de cartas == nulls

  frecuencias = new int[4];             // Vector de frecuencias == nulls
  pie = new PieChart();                 // Creación de gráfica de pastel

  jugadores = new Jugador[4];           // Creación de jugadores
  for (int i = 0; i< jugadores.length; i++)
    jugadores[i] = new Jugador(i);
}


int i = 0, j =0, h = 0, fc, r, c;
String [] nombres ={"Oros", "Copas", "Espadas", "Bastos"};
int[] may = {-1, -1, 0}; //{r,c,j}     // Arreglo que contiene datos correspondientes al ganador por lanzamiento
int[] juegGanados = new int[4];        // Contadores de Juegos ganados por jugador
int[] lanzGanados = new int[4];        // Contadores de lanzamientos ganados por jugador

void draw() {
  if (corre) {
    fc = frameCount-1;
    j = fc % 4;          // j: Jugador:     0 --> 4
    //j = fc % 40;         // h: Lanzamiento: 0 --> 10
    //i = fc % 40;          // i: Juego:       0 --> n
    if (fc < n*10*4) {
      if (fc % 40 == 0) {      //Fin de un juego
        if (i!=0) {
          despConsola();
        }

        delay(1000);           //Se le da una pausa al juego de 1 segundo

        println("---------- Juego #"+(++i)+"/"+n+" ----------");
        h = 0;
        lanzGanados = new int[4];
      }

      if (j  == 0) {        //Fin de un lanzamiento
        println("---------- Lanzamiento #"+(++h)+" ----------");
        cartastomadas = new boolean[4][10];
        for (int m = 0; m<4; m++) {                            //Establecer la parte trasera de la carta 
          jugadores[m].setDefaultImage();
          jugadores[m].display();
        }
        lanzGanados[may[2]]++;
        may[0] = -1; 
        may[1] = -1;
      }

      do {
        r = int(random(4));
        c = int(random(10));
      } while (cartastomadas[r][c]);    //Se toman valores de r y c no tomados anteriormente según la matríz booleana
      
      println("Jugador "+(j+1)+": "+ nombres[r] +" "+ (c+1));
      
      jugadores[j].setImage(cartas[r][c]);    // Se manda la carta obtenida al jugador
      jugadores[j].display();                 // Se dicha carta del jugador en la pantalla
      
      // Validaciones para ver quien es el ganador del lanzamiento...
      if (may[1] == c)             // Si se tiene el mismo valor numérico...
        if (may[0] > r) {              // Preguntar por el tipo y hacer intercambio de ser necesario
          may[0] = r;                     //Jerarquía: (+)  0 - Oro || 1 - Copas || Espadas - 2 || Bastos - 3 (-)
          may[1] = c;
          may[2] = j;
        }
      if (may[1] < c) {
        may[0] = r; 
        may[1] = c;
        may[2] = j;
      }
      cartastomadas[r][c] = !cartastomadas[r][c];
    } else {
      despConsola();
      corre = false;
    }
  }
}

void despConsola() {                    //Aquí se pueden usar ciclos, pero me dio flo----
  SumGanadores();
  println("May{r,c,j} = {"+(may[0]+1)+","+(may[1]+1)+","+(may[2]+1)+"}//"+lanzGanados[0]+" "+lanzGanados[1]+" "+lanzGanados[2]+" "+lanzGanados[3]+" ");
  println("Frecuencias de ganadores: "+juegGanados[0]+""+juegGanados[1]+""+juegGanados[2]+""+juegGanados[3]+"");
  pie.setAngles(juegGanados);
  pie.display();
}

PImage[][] getArregloImagenes() {                    // Se subdivide la imagen Cartas.png para obtener la  
  PImage baraja = loadImage("Cartas.png", "png");    // matríz de imágenes correspondientes a la baraja
  PImage[][] temp = new PImage[4][10];
  for (int i = 0; i< 4; i++)
    for (int j = 0; j < 10; j++) {
      temp[i][j] = baraja.get(j*80, i*123, 80, 123);
    }
  return temp;
}

int getMayor(int[] frecs) {                          // Método para obtener el mayor,
  int may = frecs[0];                                // Útil para ver si hay mayores repetido en SumGanadores()
  for (int i = 1; i<frecs.length; i++)
    if (may < frecs[i])
      may = frecs[i];
  return may;
}

void SumGanadores() {                                // Se incrementa para los jugadores empatados
  ArrayList<Integer> ganados = new ArrayList<Integer>();
  for (int i = 0; i < lanzGanados.length; i++)
    if (getMayor(lanzGanados) == lanzGanados[i])     // Se obtiene el supuesto valor ganador y se almacenan en un arreglo
      ganados.add(i);                                // los índices de los que obtuvieron el mayor valor
  for (int x : ganados)                               
    juegGanados[x]++;                                // Se incrementan los jugadores que empataron
}