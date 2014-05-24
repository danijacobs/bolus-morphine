function yp = equations3 (t, y, p)

% imporant concentrations 
CMs=y(1); CML=y(2); CMmus=y(3); CMb=y(4);
C3s=y(5); C3L=y(6); C3m=y(7); C3b=y(8);
C6s= y(9); C6L= y(10); C6m=y(11); C6b=y(12);
CMu= y(13); C3u=y(14); C6u=y(15);

yp=y;

if CMb<0
    CMb=0;
end

if C3b<0
    C3b=0; 
end
if C6b<0
    C6b=0;
end

% Differential Equations 
%------Morphine Equations-----------------------------------------------

% Surgical Site- dCMs/dt 
yp(1)= -p.k6*CMs+(p.Vb/p.Vs)*p.k1*CMb;

% Liver- dCML/dt
yp(2)=-p.k5*CML+(p.Vb/p.VL)*p.k2*CMb-((p.Vmax*CML)/(p.k3m+CML))-((p.Vmax*CML)/(p.k6m+CML));

% Muscle- dCMmus/dt
yp(3)= -p.k4*CMmus+(p.Vb/p.Vmus)*p.k3*CMb;

% Blood dCMb/dt 
yp(4)= -(CMb*(p.k7+p.k3+p.k2+p.k1))+(1/p.Vb)*((p.Vs*p.k6*CMs)+(p.VL*p.k5*CML)+(p.Vmus*p.k4*CMmus));

% Urine dCMu/dt 
yp(13)= p.k7*CMb*(p.Vb/p.Vu);
    
%------Morphine-3-Glucuroninde----------------------------------------
%dC3s/dt Surgical Site 
yp(5)=((p.Vb/p.Vs)*p.k3bs*C3b)-p.k3sb*C3s;

% dC3m/dt Muscle 
yp(7)=((p.Vb/p.Vmus)*p.k3bm*C3b)-p.k3mb*C3m;

% dC3L/dt Liver
yp(6)=(p.Vb/p.VL)*p.k3bl*C3b-p.k3lb*C3L+((p.Vmax*(CML))/(p.k3m+(CML)));

%dC3b/dt Blood
yp(8)=(1/p.Vb)*((p.Vs*p.k3sb*C3s)+(p.VL*p.k3lb*C3L)+(p.Vmus*p.k3mb*C3m))-(C3b*(p.k3bs+p.k3bl+p.k3bm+p.k3bu));

%dC3u/dt Urine
yp(14)=(p.k3bu*C3b)*(p.Vb/p.Vu);
    
%------Morphine-6-Glucuroninde----------------------------------------
% 
% % dC6s/dt Surgical Site 
yp(9)=((p.Vb/p.Vs)*p.k6bs*C6b)-p.k6sb*C6s;

% dC6L/dt Liver
yp(10)=((p.Vmax*CML)/(p.k6m+CML))+(p.Vb/p.VL)*p.k6bl*C6b-p.k6lb*C6L;

% dC6m/dt Muscle 
yp(11)=((p.Vb/p.Vmus)*p.k6bm*C6b)-p.k6mb*C6m;

%dC6b/dt Blood
yp(12)=(1/p.Vb)*((p.Vs*p.k6sb*C6s)+(p.VL*p.k6lb*C6L)+(p.Vmus*p.k6mb*C6m))-(C6b*(p.k6bs+p.k6bl+p.k6bm+p.k6bu));

%dC6u/dt Urine
yp(15)=(p.k6bu*C6b)*(p.Vb/p.Vu);

%% Variable list 
% 
% Vmus= Volume in muscle compartment 
% VL= Volume in liver compartment 
% Vs= volume in surgical site
% Vb= volume of blood/plasma compartment
% CMs= concentration of morphine SS 
% CML= concentration of morphine liver
% CMmus= concentration of morphine muscle
% CMb= concentration of morphine blood
% C3s= concentration of M3G ss
% C3L= concentration of M3G liver
% C3m= concentration of M3G muscle  
% C3b= concentration of M3G blood 
% C6s= concentration of M6G ss
% C6L= concentration of M6G liver
% C6m= concentration of M6G muscle 
% C6b= concentration of M6G blood

% C0s= initial concentration of morphine in surgical site
% C0L= initial concentration of morphine in liver
% C0m= inital concentration of morphine in muscle 
% C0= initial concentration of morphine in blood 
% C0s3= initial concentration of M3G in ss
% C0L3= inital concentration of M3G in liver
% C0m3= inital concentration of M3G in muscle 
% C03= inital concentration of M3G in blood 
% C0s6= initial concentration of M6G in ss
% C0L6= inital concentration of M6G in liver
% C0m6= inital concentration of M6G in muscle 
% C06= inital concentration of M6G in blood 
% C0u3= inital concentration of M3G in Urine
% C0u6= initial concentration of M6G in Urine 
% C0u= inital concentration of Morhpine in Urine

% Curine= urine constant for Morphine
% k1= morphine from blood to surgical site
% k2= morphine from blood to liver
% k3= morphine from blood to muscle 
% k4= morphine from muscle to blood
% k5= morphine from liver to blood
% k6= from surgical site to blood
% k7 from blood to urine (extretion)

% k3sb= rate from ss to blood for M3G
% k3bs= rate from blood to ss for M3G
% k3lb= rate from liver to blood for M3G
% k3bl= rate from blood to liver for M3G
% k3mb= rate from muscle to blood for M3G
% k3bm= rate from blood to muscle for M3G

% k6sb= rate from ss to blood for M6G
% k6bs= rate from blood to ss for M6G
% k6lb= rate from liver to blood for M6G
% k6bl= rate from blood to liver for M6G
% k6mb= rate from muscle to blood for M6G
% k6bm= rate from blood to muscle for M6G

% k3bu= rate of M3G from blood to urine
% k6bu= rate of M6G from blood to urine
%%



