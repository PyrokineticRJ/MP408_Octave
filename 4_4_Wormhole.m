
clc # Clear the Command Window

d = input("Distance between Entrance & Exit of wormhole : ");
R = input("Radius of Wormhole : ");

x0 = input("Initial x coordinate of Particle : ");
y0 = input("Initial y coordinate of Particle : ");

v0 = input("Velocity of Particle : ");
theta = input("Initial Angle : ");

tf=100; #total simulation time
dt=0.5; #time steps

theta=(pi/180)*theta; # convert theta to radian
i=1; #counter
t=1; #initial time
x=x0;
y=y0;
vx=v0*cos(theta); #x componant of velocity
vy=v0*sin(theta); #y componant of velocity

#coordinates of circle
xc1=0.5*d;
yc1=0;
xc2=-0.5*d;
yc2=0;

xm=[]; #x matrix to store data of particle's x coordinates 
ym=[]; #y matrix to store data of particle's y coordinates 


while t<tf
  t=i*dt;
  x=x+(vx*dt);
  y=y+(vy*dt);
 
  xm(i)=x;
  ym(i)=y;
  
  r1=sqrt((x-xc1)^2+(y-yc1)^2);
  r2=sqrt((x-xc2)^2+(y-yc2)^2);
  
  if r1<=R
    xc=0.5*d;
    yc=0;
    theta=atan2(y-yc,x-xc);
    x=-xc-R*cos(theta);
    
    #Velocity transformation 
    vr=(vx*cos(theta))+(vy*sin(theta));
    v0=(-vx*sin(theta))+(vy*cos(theta));
    vx=(vr*cos(theta))+(v0*sin(theta));
    vy=(-vr*sin(theta))+(v0*cos(theta));
    
    x=x+(vx*dt);
    y=y+(vy*dt);
  endif
  if r2<=R
    xc=-0.5*d;
    yc=0;
    theta=pi-atan2(y-yc,x-xc);
    x=-xc+R*cos(theta);
    
    #Velocity transformation 
    vr=(-vx*cos(theta))+(vy*sin(theta));
    v0=(vx*sin(theta))+(vy*cos(theta));
    vx=(-vr*cos(theta))+(-v0*sin(theta));
    vy=(-vr*sin(theta))+(v0*cos(theta));
    
    x=x+(vx*dt);
    y=y+(vy*dt);
  endif
  i++;
endwhile

figure;
hold on
theta1=0:0.01:2*pi; 

# Plotting the holes
a1=(d/2)+R*cos(theta1);
b1=R*sin(theta1);
a2=-(d/2)-R*cos(theta1);
b2=R*sin(theta1);

fill(a1,b1,[0,0,0.4],'edgecolor',[0,0,0.4])
fill(a2,b2,[0,0,0.4],'edgecolor',[0,0,0.4])

for t=1:i-1
hold on

#Ploting the Particle trajactory 
p=plot(xm(t),ym(t),'.r','markersize',30);
pause(0.01)
delete(p)
end 
#-------------------------------------------------------------------------------
#                               END OF PROGRAM
#-------------------------------------------------------------------------------