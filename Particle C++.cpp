#include <istream>
#include <SFML/Graphics.hpp>
#include <math.h>
#include <vector>
#include <iostream>
using namespace std;
class particle
{
public:
    double fx, fy, fvx, fvy, fm, fs;
    ////////////////////////////////////
    particle(double x, double y, double vx, double vy, double m, double s)
    {
        fx = x;
        fy = y;
        fvx = vx;
        fvy = vy;
        fm = m;
        fs = s;
    }

    ////////////////////////////////////////
    double Set_r(double x, double  y)
    {
        fx = x;
        fy = y;
        return(fx);
        return(fy);
    }
        //////////////
    double Set_s(double s)
    {
        fs = s;
        return(fs);
    }
    /////
     double Set_v(double vx, double vy)
    {
        fvx = vx;
        fvy = vy;
        return(fvx);
        return(fvy);
    }
 };
////////////////////////////////////
vector <particle> p;
double x, y, vx, vy, s, dt = 0.0005, Fw, Fwx,Fwy; int Nmax = 500000000000, N = 200, m = 1.67/pow(10,19), Q0 = 3, e = 5;
///////8/////////степ////////////
void Step()
{ //cout << 2 << endl;
    for (int i = 0; i < N - 1;i++)
    {
        x = p[i].fx; y = p[i].fy; vx = p[i].fvx; vy = p[i].fvy;  s = p[i].fs;
        x += vx* dt;     
        y += vy * dt;
        if (pow(x,2) > 160000)
            vx = -vx;
        if (pow(y, 2) > 160000)
            vy = -vx;
        p[i].fx = x;
        p[i].fvx = vx;
        p[i].Set_r(x, y);
        p[i].Set_v(vx, vy);
        }
}
///8///взвешивание///
void weighing()
{
    for (int q = 0; q < N - 1; q++)
    {////равноде2йствующая сила
        for (int j = q + 1; j < N - 1;j++)
        {
            s = sqrt(pow((p[j].fx - p[q].fx), 2) + pow((p[j].fy - p[q].fy), 2));
            if (s >= 2.5 * Q0)
                Fw = 0;
            else
                Fw = -24 * e * pow(Q0, 6) / pow(s, 7) + 48 * e * pow(Q0, 12) / pow(s, 13);
            Fwx += Fw * (p[q].fx - p[j].fx) / s;
            Fwy += Fw * (p[q].fy - p[j].fy) / s;
            p[q].fvx += Fwx * dt / m;
            p[q].fvy += Fwy * dt / m;    //меняется первый объект
             //////////////////////
            p[j].fvx -= Fwx * dt / m;   //меняется второй объект
            p[j].fvy -= Fwy * dt / m;
            // sf::sleep(sf::seconds(0.01));
        };
    };
}

////////////2/////////base////////////////////////
int main()
{
    sf::RenderWindow window(sf::VideoMode(1280, 720), "Particle");
    sf::Event event;

    for (int i = 0; i < N;i++)
    {  
        particle A((rand() % 399 + 1.0), rand() % 399 + 1.0, (rand() % 20000 + 1.0), (rand() % 20000 + 1.0), m, s);
        p.push_back(A);
    }
    //////8//////////////////////////////////////////////////////////////
    sf::VertexArray particle2(sf::Points, N);
            for (int i = 0; i < N; i++)
        {
            particle2[i].position = sf::Vector2f(p[i].fx*10+400, p[i].fy*10+350);
            particle2[i].color = sf::Color::Red;
        }
        /////////////2/////////////////////8///////
    while (window.isOpen())
    {
        int U = 0;
        while (window.pollEvent(event))
        {
            if ( (event.type == sf::Event::Closed) || ( U > Nmax) )
                window.close();
        }
        U++;
        Step();
        weighing();
        window.display();
        for (int n = 0;n < N; n++)
           // cout << n << ") x =" << p[n].fx << " | y= " << p[n].fy << " | vx = " << p[n].fvx << " | vy = " << p[n].fvy << endl;
        window.draw(particle2);
    }
    return 0;
}