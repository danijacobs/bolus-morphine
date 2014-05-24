
% ******************************************
% Morphine Bolus Model 
% Honors Thesis 
% Date: Tuseday January 7, 2014
% Name: Danielle Jacobs 
%********************************************
close all; clear all; clc
p.k1=999e-9; %9e-7
p.k2=1e-4; 
p.k3=1e-4;
p.k4=1e-5;
p.k5=1e-5; 
p.k6=999e-7;
p.k7=2e-4; %blood M to urine
p.k3sb=1e-3; 
p.k3bs=1e-4;
p.k3lb=5e-2; 
p.k3bl=1e-3;
p.k3mb=1e-4; 
p.k3bm=1e-5; 
p.k3bu=9e-5;  
p.k6sb=1e-3;
p.k6bs=1e-4;
p.k6lb=1e-2;
p.k6bl=5e-3;
p.k6mb=1e-4;
p.k6bm=1e-5;
p.k6bu=9e-5;
p.C0s=3100; 
p.C0L=0;
p.C0m=0;
p.C0u=0;
p.C0= 0;%31000; %inital value in blood in mmol/l
p.C0s3=0;
p.C0L3=0;
p.C0m3=0;
p.C03=0;
p.C0s6=0;
p.C0L6=0;
p.C0m6=0;
p.C06=0; 
p.C0u3=0;
p.C0u6=0;

p.Vb= 5.200 ; %3.2 L or 3200ml
p.VL= 1.690; %volume of the liver in ml or cc
p.Vmus= 35.00; %3.2 L or 3200 ml 
p.Vs= 1.103; %1.03ml of volume on site
p.Vu= 2.550; %550ml or .550l


p.Vmax= 9.731*10^-1; %in nmol/s
p.k3m=25*(1/8); %nM
p.k6m=25; %nM

p.tf=48*60*60; % 12*7*24*60*60;% seconds

y0=[p.C0s p.C0L p.C0m p.C0 p.C0u p.C0s3 p.C0L3 p.C0m3 p.C03 p.C0u3 p.C0s6 p.C0L6 p.C0m6 p.C06 p.C0u6];
options = odeset('AbsTol', 1e-9, 'RelTol', 1e-6);
[t y] = ode15s(@equations4, [0 p.tf], y0, options, p);

max= max(y(:,8));


%%
% **************** Morphine and compartments***********
figure(17);
subplot(3,2,1); % plot blood top left corner
plot (t, y(:,4)); 
title('Morphine in Blood');
xlabel('Time (s)');
ylabel('Morphine (nmol/L)');
subplot(3,2,2);
plot(t, y(:,1)); %plot morphine of surgical top right corner
title('Morphine in CSF');
xlabel('Time (s)');
ylabel('Morphine (nmol/L)');
subplot(3,2,3); %plot morphine in musclie middle left 
plot(t,y(:,3));
title('Morphine Muscle');
xlabel('Time (s)');
ylabel('Morphine (nmol/L)');
subplot(3,2,4); % plot of morphine in Liver
plot(t, y(:,2));
title('Morphine liver');
xlabel('Time (s)');
ylabel('Morphine (nmol/L)');
subplot(3,2,5); %plot of M3G in Liver
plot(t, y(:,13));
title('Morphine Urine');
xlabel('Time (s)');
ylabel('Morphine (nmol/L)');
%***************plot of M3G in compartments*******************
figure(18);
subplot(3,2,1); % plot blood top left corner
plot (t, y(:,8)); 
title('M3G in Blood');
xlabel('Time (s)');
ylabel('M3G (nmol/L)');
subplot(3,2,2);
plot(t, y(:,5)); %plot m3g of surgical top right corner
title('M3G in CSF');
xlabel('Time (s)');
ylabel('M3G (nmol/L)');
subplot(3,2,3); %plot morphine in musclie middle left 
plot(t,y(:,7));
title('M3G Muscle');
xlabel('Time (s)');
ylabel('M3G (nmol/L)');
subplot(3,2,4); % plot of M3G in Liver
plot(t, y(:,6));
title('M3G liver');
xlabel('Time (s)');
ylabel('M3G (nmol/L)');
subplot(3,2,5); %plot of M3G in Urine
plot(t, y(:,14));
title('M3G Urine');
xlabel('Time (s)');
ylabel('M3G (nmol/L)');
%**********************plot of M6G in compartments*****************
figure(19);
subplot(3,2,1); % plot blood top left corner
plot (t, y(:,12)); 
title('M6G in Blood');
xlabel('Time (s)');
ylabel('M6G (nmol/L)');
subplot(3,2,2);
plot(t, y(:,9)); %plot m3g of CSF top right corner
title('M6G in CSF');
xlabel('Time (s)');
ylabel('M6G (nmol/L)');
subplot(3,2,3); %plot morphine in musclie middle left 
plot(t,y(:,11));
title('M6G Muscle');
xlabel('Time (s)');
ylabel('M6G (nmol/L)');
subplot(3,2,4); % plot of M3G in Liver
plot(t, y(:,10));
title('M6G liver');
xlabel('Time (s)');
ylabel('M6G (nmol/L)');
subplot(3,2,5); %plot of M3G in Urine
plot(t, y(:,15));
title('M6G Urine');
xlabel('Time (s)');
ylabel('M6G (nmol/L)');

figure(28);
subplot(3,1,1); % plot blood top left corner
plot (t, y(:,1)); 
title('Morphine in CSF');
ylabel('Concentration (nmol/L)')
subplot(3,1,2);
plot(t, y(:,5)); %plot m3g of CSF top right corner
title('M3G in CSF');
ylabel('Concentration (nmol/L)')
subplot(3,1,3); %plot morphine in musclie middle left 
plot(t,y(:,9));
title('M6G in CSF');
ylabel('Concentration (nmol/L)')
xlabel('Time (s)');
