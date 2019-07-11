import processing.serial.*; 
Serial roteador;
Serial roteador2;

Bot bot1;
Bot bot2;
Bot bot3;
Bot bot4;
Arexib arexib1;
Arexib arexib2;
Arexib arexib3;
Arexib arexib4;
Arexib scope1;
Arexib scope2;
Dispbox dispbox1;
Dispbox dispbox2;

float[] sinal1x = new float[375];
float[] sinal1y = new float[200];
int buff_cont=300;
int plot_cont=0;
float[] infloat_buff = new float[375];

float[] sinal2x = new float[375];
float[] sinal2y = new float[200];
int buff_cont2=300;
int plot_cont2=0;
float[] infloat2_buff = new float[375];

PImage img1;
PImage img2;
PFont f1;
static String inString; // String que recebe a informação via serial
static float infloat;

static String inString2; // String que recebe a informação via serial
static float infloat2;

int lf=10; // Códico ASCII para Line Feed
    //Array de Strings com as informações de entrada
static String temp ="0";
int mousex;
int mousey;
int botflag=1;
static String datain = "0";

/* Mapeamento dos botões em pixels, onde botnx d botny são as coordenadas x e y do
botao. botxlarg e botylarg são as larguras x e y dos botões respectivamente. n*/
static final int bot1x=20;
static final int bot1y=124;
static final int botxlarg=122;
static final int botylarg=46;
static final int bot2x=20;
static final int bot2y=217;
static final int bot3x=20;
static final int bot3y=310;
static final int bot4x=20;
static final int bot4y=403;



void setup(){
  
  size(870,579);
  img1=loadImage("fundo.png"); 
  img2=loadImage("estatua_01.png");
  f1= createFont("Arial",20);
  
  //roteador = new Serial(this, Serial.list()[0], 9600);  //ATENÇÃO: Se não houver nada conectado no serial comente essa linha
 // roteador = new Serial(this, "COM8", 115200);  //ATENÇÃO: Se não houver nada conectado no serial comente essa linha
  //roteador.bufferUntil(lf);   //ATENÇÃO: Se não houver nada conectado no serial comente essa linha
  roteador2 = new Serial(this, "COM10", 115200);  //ATENÇÃO: Se não houver nada conectado no serial comente essa linha
  roteador2.bufferUntil(lf);   //ATENÇÃO: Se não houver nada conectado no serial comente essa linha
  
  // Instanciando Objetos
  bot1= new Bot(bot1x,bot1y,botxlarg,botylarg,"Balança 1");
  bot2= new Bot(bot2x,bot2y,botxlarg,botylarg,"Balança 2");
  bot3= new Bot(bot3x,bot3y,botxlarg,botylarg,"Proximidade");
  bot4= new Bot(bot4x,bot4y,botxlarg,botylarg,"Opções");  
  
  arexib1= new Arexib("Balança 1",246,93,495,465);
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  arexib2= new Arexib("Balança 2",246,93,495,465);
  arexib3= new Arexib("Sonda Indutiva",246,93,495,465);
  arexib4= new Arexib("Opções",246,93,495,465);
  scope1 = new  Arexib("",300,300,375,200);
  scope2 = new  Arexib("",300,300,375,200);
  
  dispbox1= new Dispbox(400,180,180,70);
  dispbox2= new Dispbox(600,300,100,20);
  
  // Inicialização do fundo padrão


}

void draw(){

  mousex=mouseX;
  mousey=mouseY;
  //println(mousex, mousey,botflag);
 // temp=datain[2];
  
  
  switch (botflag){
    case 1:
      arexib1.clean();
      arexib1.display();
      scope1.drawaxis();
      scope1.display();
      dispbox1.display(infloat);
     // dispbox2.displaystr("Não Pressionado");
     
     for(int i=0;i<plot_cont+1;i=i+1){
           stroke(255,100,160); 
           circle(300+i,400-(0.05*infloat_buff[i]),2);
           stroke(0);
       // beginShape();
       //   vertex(buff_cont,400-infloat);
       // endShape();
     }
    break;
    case 2:
      arexib2.clean();
      arexib2.display();
      scope2.drawaxis();
      scope2.display();
      dispbox1.display(infloat2);


    //  dispbox2.displaystr("Pressionado");
for(int i=0;i<plot_cont2+1;i=i+1){
           stroke(210,120,110);
           circle(300+i,400-(0.05*infloat2_buff[i]),2);
           stroke(0);
       // beginShape();
       //   vertex(buff_cont,400-infloat);
       // endShape();
     }
    break;
    case 3:
      arexib3.clean();
      arexib3.display(); 
      dispbox1.display(infloat);
   //   dispbox2.displaystr("Tres");
    break;
    case 4:
      arexib4.clean();
      arexib4.display();
      dispbox1.display(infloat);
   //   dispbox2.displaystr("temp");      
      break;

  }

}

  void serialEvent(Serial inport) { 
    
    if (inport==roteador){  
    inString = roteador.readString(); 
    buff_cont++;
    plot_cont++;
    if (buff_cont>674){
      buff_cont=300;
      plot_cont=0;
             }
    
    //datain=split(inString, '&');
    infloat=float(inString);
    infloat_buff[plot_cont]=infloat;
    println(buff_cont);
    }
    
    if (inport==roteador2){
    inString2 = roteador2.readString(); 
    buff_cont2++;
    plot_cont2++;
    if (buff_cont2>674){
      buff_cont2=300;
      plot_cont2=0;
             }
    
    //datain=split(inString, '&');
    infloat2=float(inString2);
    infloat2_buff[plot_cont2]=infloat2;
    println(buff_cont2);
    }

   }


   


void mousePressed(){
  if(mousex>bot1x && mousex<(bot1x+botxlarg) && mousey>bot1y && mousey<(bot1y+botylarg)){
    botflag=1;     
    bot1.click();  
  }
  if(mousex>bot2x && mousex<(bot2x+botxlarg) && mousey>bot2y && mousey<(bot2y+botylarg)){
    botflag=2;
    bot2.click();
  }
  
  if(mousex>bot3x && mousex<(bot3x+botxlarg) && mousey>bot3y && mousey<(bot3y+botylarg)){
    botflag=3;
    bot3.click();
  }
    if(mousex>bot4x && mousex<(bot4x+botxlarg) && mousey>bot4y && mousey<(bot4y+botylarg)){
    botflag=4;     
    bot4.click();  
  }
  }
void mouseReleased(){
   bot1.display();
   bot2.display();
   bot3.display();
   bot4.display();
   loop();
   
}





class Bot{
  int xpos;
  int ypos;
  int xlarg;
  int ylarg;
  String label;
  
  
  public Bot(int xpos_,int ypos_,int xlarg_,int ylarg_,String label_){
    xpos=xpos_;
    ypos=ypos_;
    xlarg=xlarg_;
    ylarg=ylarg_;
    label=label_;

    
  }
  
  void display(){
    
    fill(200);
    rect(xpos,ypos,xlarg,ylarg);
    fill(0);
    textAlign(CENTER);
    textFont(f1);
    text(label,(xpos+xlarg/2),(ypos+ylarg/2));

  
  }
  
  void click(){

    fill(180);
    rect(xpos,ypos,xlarg,ylarg);
    fill(0);
    textAlign(CENTER);
    textFont(f1,11);
    text(label,(xpos+xlarg/2),(ypos+ylarg/2));
    noLoop();
    

    
  }

  
}

class Arexib{
  String title;
  int aex;
  int aey;
  int aexlarg;
  int aeylarg;
  
  public Arexib(String title_,int aex_,int aey_,int aexlarg_,int aeylarg_){
    title=title_;
    aex=aex_;
    aey=aey_;
    aexlarg=aexlarg_;
    aeylarg=aeylarg_;
  }
  
  void display(){
    fill(0);
    textAlign(CENTER);
    textFont(f1,30);
    text(title,(aex+aexlarg/2),(aey+aeylarg/7));  
  }
  
    void clean(){
    background(0);
    image(img1,0,0);
    fill(160,170);
    rect(0,62,185,496);
    rect(aex,aey,aexlarg,aeylarg);
    bot1.display();
    bot2.display();
    bot3.display();
    bot4.display();
    fill(40);
    textAlign(CENTER);
    textFont(f1,30);
    text("Instrumento Virtual",435,45);
    fill(40);
    textAlign(CENTER);
    textFont(f1,30);
    text("Menu",92,93);
    
  }
  
  void drawaxis(){
    fill(230,100);
    rect(aex,aey,aexlarg,aeylarg);
    fill(160,170);
    rect(0,62,185,496);
    bot1.display();
    bot2.display();
    bot3.display();
    bot4.display();
    fill(40);
    textAlign(CENTER);
    textFont(f1,30);
    text("Instrumento Virtual",435,45);
    fill(40);
    textAlign(CENTER);
    textFont(f1,30);
    text("Menu",92,93);
  }
    
}

class Dispbox{
  int xpos;
  int ypos;
  int xlarg;
  int ylarg;
  float valorn;
  String valors;
  
  public Dispbox(int xpos_, int ypos_, int xlarg_, int ylarg_){
    xpos=xpos_;
    ypos=ypos_;
    xlarg=xlarg_;
    ylarg=ylarg_;
  }
  void display(float valorn_){
    valorn=valorn_;
    fill(255,210);
    rect(xpos,ypos,xlarg,ylarg);
    fill(0);
    textAlign(CENTER);
    textFont(f1);
    text(valorn,(xpos+xlarg/2),(ypos+ylarg/2)+5);
  }
  
  void displaystr(String valors_){
    valors=valors_;
    fill(255,220);
    rect(xpos,ypos,xlarg,ylarg);
    fill(0);
    textAlign(CENTER);
    textFont(f1);
    text(valors,(xpos+xlarg/2),(ypos+ylarg/2)+5);
  }
  
}
