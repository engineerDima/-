uses graphabc;
//uses graph3D;
type
  particle = class
  private
    fx: real;
    fy: real;
    fz: real;
    fvx: real;
    fvy: real;
    fvz: real;
    fm: real;
    //fF: real;
   fR: real;
  ////////////////////////////////////
  public
    constructor Create(x: real; y: real; z:real; vx: real; vy: real; fvz:real; m: real; R: real);
    begin
      fx := x;
      fy := y;
      fz := z;
      fvx := vx;
      fvy := vy;
      fvz := vz;
      fm := m;
      fR := R;
      //fF := F;
      
    end;
    ////////////////////////////////////////
    procedure Set_r(x: real; y: real; z : real);
    begin
      fx := x;
      fy := y;
      fz := z;
    end;
    
    procedure Set_v(vx: real; vy: real; vz: real );
    begin
      fvx := vx;
      fvy := vy;
      fvz := vz;
    end;
    ///////////////////////
    property x: real read fx;
    property y: real read fy;
    property z: real read fz;
    property vx: real read fvx;
    property vy: real read fvy;
    property vz: real read fvz;
    property m: real read fm;
    property R: real read fR;
    
  end;
////////////////////////////////////
var
  x: real;

var
  y: real;
  
var
  z: real;

var
  vx: real;

var
  vy: real;
var
  vz: real;

var
  m: real;
var 
  R: real;
var
 Q0: real := 1.2;
 
 var
  e : real := 1.2;

var
  dt: real := 0.001;

var 
  E0: real;  
var
  Fw: real;

var
  Fwx: real;

var
  Fwy: real;

var
  s: real;
 
var
  U: integer;
////////////////степ////////////
procedure Step(dt: real; params p: array of particle);
begin
  for i: integer := 0 to p.Length - 1 do
  begin
    x := p[i].fx; y := p[i].fy;z := p[i].fz; vx := p[i].fvx; vy := p[i].fvy; vz := p[i].fvz; R := p[i].fR;
    //if x == 
    x += vx * dt;
    y += vy * dt;
    z += vz * dt;
    //Fwx := F;
    //Fwy := 0;
    if sqr(x) > 10000 then begin
      vx := -0.9*vx;
      
    //Fwx := -Fwx;
    end;
    if sqr(y) > 1000 then begin
      vy := -0.9*vy;  
      end;
    if sqr(z) > 10000 then begin
      vz := -0.9*vz; 
      
      end;
    p[i].Set_r(x, y, z);
    p[i].Set_v(vx, vy, vz);
     if U mod 2 = 0 then begin
     //SetPixel(round(x * 0.7 + 200), round(y * 0.3 + 150), clBlack);
   //  if x>=500 then begin x := 100 end;
   //  if x<=-500 then  begin x := -100 end;
   //  if y>=500 then begin y := 100 end;
   //  if y<=500 then begin y := 100 end;
     Circle(round(x * 1280/1000 + 680), round(-y * 720/1000 + 360), round(R));
   FloodFill(round(x * 1280/1000 + 680), round(-y * 720/1000 + 360),clBlack);
   writeln(x, ' ',y, ' ', vx);
    // sleep(1000);
     
     //setbrushcolor(clRed);
     end; 
     end;
     end;
 //////взвешивание///
procedure weighing(params p: array of particle);
begin   
    for q: integer := 0 to p.Length - 1 do
    begin////равнодействующая сила
    Fwx := 0;
    Fwy := 0;
      for j: integer := q + 1 to p.Length - 1 do
      begin
        s := sqrt(sqr(p[j].x - p[q].x) + sqr(p[j].y - p[q].y));
        Fw := -24 * e * Power(Q0,6) / Power(s,7) + 48 * e * Power(Q0,12) / Power(s,13); 
        Fwx += Fw * (p[q].x-p[j].x) / s;
        Fwy += Fw * (p[q].y-p[j].y) / s;
        //Fwx -= 100*vx;
        //Fwx -= 100*vy;
        p[q].fvx += Fwx*dt / m ;
        p[q].fvy += Fwy*dt / m;    //меняется первый объект
        /////////////////8/////
        p[j].fvx -= Fwx*dt / m ;   //меняется второй объект
        p[j].fvy -= Fwy*dt / m;
        //if sqr(s-0.011222)<0.01 then begin
          E0 := sqrt(sqr(p[q].fvx)+sqr(p[q].fvy)) ;
          // s < 0.01 then
            //writeln(E0,' ', s);
          
          //if E0 >1/1000 8then
            //writeln(E0);
          //if U mod 100 =0 then
           //writeln({'E0 = ', E0{,' объекты ', q+1, j+1,'r = ',} s{, ' Fw = ', Fw{,' Q0 = ', Q0, ' e =', e});
           //sleep(100);
           //if sqr(Fw)< 1/9000000000 then 
           // if s<20 then
              // writeln(s);
            // sleep(10);
    end;
   end; 
  end;
  //writeln('s =', s, ' i=', i, ' j=', j,' Fw= ', Fw);
        //

/////////////////////base////////////////////////
begin
  //SetWindowWidth(4000);
  // SetWindowHeight(30800);
  var p: array of particle := new particle[50];
  for i: integer := 0 to 49 do 
    p[i] := new particle(50*i-500, 20*i-300, 0, -10*i, 0, 0, 0.21,10);
   // p[1] := new particle(0, 0, 0, 0, 0, 0, 0.21,3); 
   // p[0] := new particle(0, 200, 0, 0, 0, 0, 0.21, 3);
   // p[2] := new particle(5, 0, 0, -1, 0, 0, 0.21, 3);
    //p[3] := new particle(1, 1, 0, 0, m, Q0, e, Fw, s, Fwx, Fwy);
    for U := 0 to 1000000 do
  begin
    //u : real := U
    //if U mod 100 = 0 then begin
      //print('Hello', milliseconds / 1000);
      //exit;
      //writeln(U,' объекты ', q+1, j+1,' r =', s, ' Fw =', Fw{,' Q0 = ', Q0, ' e =', e});
    //end;
    Step(dt, p);
    weighing(p);
    ClearWindow;
  end;
  //print('Hello!');
  {while sqr(x) <= 10000 do
  Step(dt, p);} 
end.