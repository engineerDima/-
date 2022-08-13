////////////class
class particle
{
  float fx, fy, fz, fvx, fvy, fvz, fm, fR;
  ////////////////////////////////////
  particle(float x, float y,float z, float vx, float vy, float vz, float m, float R)
  {
    fx = x;
    fy = y;
    fz =z;
    fvx = vx;
    fvy = vy;
    fvz =vz;
    fm = m;
    fR = R;
  }
  ///////////
  void Set_r(float x, float  y, float z)
  {
    fx = x;
    fy = y;
    fz = z;
  }
  //////////////
  void Set_v(float vx, float vy, float vz)
  {
    fvx = vx;
    fvy = vy;
    fvz = vz;
  }
};
///////

///array of particle
void filling() {
for (int i =0; i<N; i++){
 particle a = new particle (random(180*1.415)-90.0*1.415, random(120*1.415)-60.0*1.415, random(200)-100.0, random(10)-5.0, random(10)-5.0, random(10)-5.0, 0.21, 5.0);
// particle a = new particle(5*Q0*pow(2,1/6)*i, 0, 100.0, 0.0, 0.0, 0.0,2.1, 3.0);
 
  p.add(a);
}
/////
}

void Step()
{ //cout << 2 << endl;
  filling();
  for (int i = 0; i < N; i++)
  {
    x = p.get(i).fx;
    y = p.get(i).fy;
    z = p.get(i).fz;
    vx = p.get(i).fvx;
    vy = p.get(i).fvy;
    vz = p.get(i).fvz;
    x += vx * dt;
    y += vy * dt;
    if (pow(x, 2) > 8100*2)
      vx = -0.9*vx;
    if (pow(y, 2) > 3600*2)
      vy = -0.9*vx;
      if (pow(z, 2) > 3600*2)
      vz = -0.9*vz;
     /* if ((x<=0)||(x>=1280))
        vx = -vx;
      if ((y<=0)||(y>=720))    
          vy = -vy;*/
      
    p.get(i).Set_r(x, y,z);
    p.get(i).Set_v(vx, vy,vz);
    ///////////drawning
    
    pushMatrix();
         translate(p.get(i).fx*1280/500+width/2, height/2-p.get(i).fy*720/500, p.get(i).fz);
    //position of ball
    noStroke();
    fill(0, 120, 256); //blue
    sphere(p.get(i).fR); //radius of ball is 30
   
    popMatrix();
    //delay(10);
    }
    //print(x);
  
}
////
void weighing()
{
  
  for (int q = 0; q < N - 1; q++)
  {////равнодействующая сила
    Fwx = 0;
    Fwy = 0;
    Fwz = 0;
    //print(" ",Q0);
    for (int j = q + 1; j < N; j++)
    {
     // print(" ",Q0, " ");
      s = sqrt(pow((p.get(j).fx - p.get(q).fx), 2)+ pow((p.get(j).fz - p.get(q).fz), 2) + pow((p.get(j).fy - p.get(q).fy), 2));
      Fw = -24 * e * pow(Q0, 6) / pow(s, 7) + 48 * e * pow(Q0, 12) / pow(s, 13);
      Fwx += Fw * (p.get(q).fx - p.get(j).fx) / s;
      Fwy += Fw * (p.get(q).fy - p.get(j).fy) / s;
      Fwz += Fw * (p.get(q).fz - p.get(j).fz) / s;
      
      p.get(q).fvx += Fwx * dt / m;
      p.get(q).fvy += Fwy * dt / m; 
      p.get(q).fvz += Fwz * dt / m; //меняется первый объект
      //////////////////////
      p.get(j).fvx -= Fwx * dt / m;   //меняется второй объект
      p.get(j).fvy -= Fwy * dt / m;
      p.get(j).fvz -= Fwz * dt / m;
      
      E0 = sqrt(pow(p.get(q).fvz, 2)+pow(p.get(q).fvx, 2) + pow(p.get(q).fvy, 2));
      // sf::sleep(sf::seconds(0.01));
      //print(p.get(q).fvz);
       
    };
  };
}

void setup() { 
  size(1360, 720, P3D);
}

///////////////***********************************************************//////////////////
int U =0;
//import java.io.*;

void draw() {
  background(255);
  //rotateY(angle);
   U ++;
  pointLight(256, 256, 256, width/2, height/4, 0);
// rect(-90*2*1280/500+width/2, height/2-60*2*720/500, 180*2*1280/500,120*2*720/500);
    line(-90*2*1280/500+width/2, height/2-60*2*720/500, 100, 90*2*1280/500+width/2,  height/2-60*2*720/500,100);
   // delay(1000);
   // strokeWeight();
    line(90*2*1280/500+width/2,  height/2-60*2*720/500,100, 90*2*1280/500+width/2,  height/2+60*2*720/500,100);
    line(90*2*1280/500+width/2,  height/2+60*2*720/500,100, -90*2*1280/500+width/2, height/2+60*2*720/500,100);
    line(-90*2*1280/500+width/2, height/2+60*2*720/500,100, -90*2*1280/500+width/2, height/2-60*2*720/500,100);
  /////2Запись в файл
  line(-90*2*1280/500+width/2, height/2-60*2*720/500,-100, 90*2*1280/500+width/2,  height/2-60*2*720/500,-100);
    line(90*2*1280/500+width/2,  height/2-60*2*720/500,-100, 90*2*1280/500+width/2,  height/2+60*2*720/500,-100);
    line(90*2*1280/500+width/2,  height/2+60*2*720/500,-100, -90*2*1280/500+width/2, height/2+60*2*720/500,-100);
    line(-90*2*1280/500+width/2, height/2+60*2*720/500,-100, -90*2*1280/500+width/2, height/2-60*2*720/500,-100);
    /////////////////////
    line(-90*2*1280/500+width/2, height/2-60*2*720/500,100, -90*2*1280/500+width/2,  height/2-60*2*720/500,-100);
    line(90*2*1280/500+width/2,  height/2-60*2*720/500,100, 90*2*1280/500+width/2,  height/2-60*2*720/500,-100);
    line(90*2*1280/500+width/2,  height/2+60*2*720/500,100, 90*2*1280/500+width/2, height/2+60*2*720/500,-100);
    line(-90*2*1280/500+width/2, height/2+60*2*720/500,100, -90*2*1280/500+width/2, height/2+60*2*720/500,-100);
    ///////////////////////////////////////
 /*   line(-90*2*1280/500+width/2, height/2-60*2*720/500,100, 90*2*1280/500+width/2,  height/2-60*2*720/500,-100);
    line(90*2*1280/500+width/2,  height/2-60*2*720/500,100, 90*2*1280/500+width/2,  height/2+60*2*720/500,-100);
    line(90*2*1280/500+width/2,  height/2+60*2*720/500,-100, -90*2*1280/500+width/2, height/2+60*2*720/500,-100);
    line(-90*2*1280/500+width/2, height/2+60*2*720/500,-100, -90*2*1280/500+width/2, height/2-60*2*720/500,-100);*/
    ////////////////////////////////////////
  //File file = new File("D:/Test.txt");
  //PrintWriter pw = new PrintWriter("D:/Test.txt", true);
 /* try(FileReader reader = new FileReader("Test.txt"))
        {
           // запись всей строки
          /*  String text = "Hello Gold!";
            writer.write(text);
            // запись по символам
            writer.append('\n');
            writer.append('E');
             
            writer.flush();
            int c;
            while((c=reader.read())!=-1){
                 
                System.out.print((char)c);8
        }
        }
        catch(IOException ex){
             
            System.out.println(ex.getMessage());
        } */
  if (U==30000)
    System.exit(0);

// Помещаем текст внутрь файла
//pw.println("Working proccess");
  ////
  Step();
  //for (int i =0; i<N; i++) line(p.get(i).fx, p.get(i).fy, p.get(i).fz, p.get(i).fx+p.get(i).fvx/100,p.get(i).fy+p.get(i).fvy/100,p.get(i).fz+p.get(i).fvz/100);
  weighing();
}

ArrayList<particle> p = new ArrayList();
float x=0, y=0, z=0, vx=0, vz=0, s=0, vy=0;
double Fw=0, Fwx=0, Fwy=0, Fwz=0, E0=0, dt = 0.005;
float Nmax = 500000000000L, N = 100, m = 2.1, Q0 = 1.2, e = 1.2; 
