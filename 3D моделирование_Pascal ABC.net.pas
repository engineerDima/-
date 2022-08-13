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
    constructor Create(x: real; y: real; z: real; vx: real; vy: real; fvz: real; m: real; R: real);
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
    procedure Set_r(x: real; y: real; z: real);
    begin
      fx := x;
      fy := y;
      fz := z;
    end;
    
    procedure Set_v(vx: real; vy: real; vz: real);
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
  e: real := 1.2;

var
  dt: real := 0.1;

var
  E0: real;

var
  Fw: real;

var
  Fwx: real;

var
  Fwy: real;

var
  Fwz: real;

var
  s: real;

var
  U: integer;
////////////////степ////////////
procedure Step(dt: real; params p: array of particle);
begin
  for i: integer := 0 to p.Length - 1 do
  begin
    x := p[i].fx; y := p[i].fy; z := p[i].fz; vx := p[i].fvx; vy := p[i].fvy; vz := p[i].fvz; m := p[i].fm; R := p[i].fR;
    //if x == 
    x += vx * dt;
    y += vy * dt;
    z += vz * dt;
    //Fwx := F;
    //Fwy := 0;
    if sqr(x) > 10000 then begin
      vx := -0.9 * vx;
      
      //Fwx := -Fwx;
    end;
    if sqr(y) > 10000 then begin
      vy := -0.9 * vy;  
    end;
    if sqr(z) > 10000 then begin
      vz := -0.9 * vz; 
      
    end;
    p[i].Set_r(x, y, z);
    p[i].Set_v(vx, vy, vz);
    SetPixel(round(x * 0.7 + 200), round(y * 0.3 + 150), clBlack);
    //P3D(x,y,z);
    //Sphere(x * 1280 / 500 + 1280 / 2, 720 / 2 - y * 720 / 500, z * 100 / 500, R, Colors.Black);
    if U mod 1000 = 0 then begin
        //p.get(i).fx*1280/500+width/2, height/2-p.get(i).fy*720/500, p.get(i).fz
      
      //var o := Sphere(x*1280/500+ 1280/2, 720/2-y*720/500, z*100/500, R, Colors.Black);
      sleep(10);
    end;
    //setbrushcolor(clRed);
  end; 
end;
 //////взвешивание///
procedure Weighing(params p: array of particle);
begin
  for q: integer := 0 to p.Length - 1 do
  begin////равнодействующая сила
    Fwx := 0;
    Fwy := 0;
    for j: integer := q + 1 to p.Length - 1 do
    begin
      s := sqrt(sqr(p[j].x - p[q].x) + sqr(p[j].y - p[q].y) + sqr(p[j].z - p[q].z));
      //Fw := -24 * e * Power(Q0, 6) / Power(s, 7) + 48 * e * Power(Q0, 12) / Power(s, 13); 
      if (s<=Power(26/7,1/6)*Q0) then begin //splains
        Fw := -24 * e * Power(Q0, 6) / Power(s, 7) + 48 * e * Power(Q0, 12) / Power(s, 13);
        end
      else 
        begin
        if (s<=67/48*Power(26/7,1/6)*Q0)then begin  
          Fw := -0.25*Power((s-67/48*Power(26/7,1/6)*Q0), 4)*387072/61009*e/Power(1.24*Q0,3)-24192/3211*e/Power(1.24*Q0,2)/3*Power((s-67/48*Power(26/7,1/6)*Q0), 3);
        end
        else Fw := 0;
      end;
        //if sqr(s-0.011222)<0.01 then begin
      E0 := sqrt(sqr(p[q].fvx) + sqr(p[q].fvy) + sqr(p[q].fvz));
      // s < 0.01 then
      writeln(p[q].x);
      //writeln(p[j].x);
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
  var p: array of particle := new particle[2];
  for i: integer := 0 to 1 do 
    p[i] := new particle(0+i*Q0, 0+i, 0, -i*5, 0, 0, 0.21, 3);
    //p[0] := new particle(x, y, z, vx,vy,vz, m, R); 
  for U := 0 to 10000000 do
  begin
    // var o := Sphere(1*1280/500+ 1280/2, 720/2-1*720/500, 1*100/500, 300, Colors.Black);
    Step(dt, p);
   // P3D(x,y,z);
    Weighing(p);
    ClearWindow;
  end;
  //print('Hello!');
  {while sqr(x) <= 10000 do
  Step(dt, p);} 
end.