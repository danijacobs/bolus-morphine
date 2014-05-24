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


p.C0s=0; 
p.C0L=0;
p.C0m=0;
p.C0u=0;
p.C0= 3100;%31000; %inital value in blood in mmol/l
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
[t y] = ode15s(@equations3, [0 p.tf], y0, options, p);

max= max(y(:,8));

%% load files
DalenameBloodM='DalevaluesBloodM.xlsx';
DalenameBloodM3G= 'DalevaluesBloodM3G.xlsx';
DalenameBloodM6G= 'DalevaluesBloodM6G';
DalenameCSFM= 'DalevaluesCSFM';
DalenameCSFM3G='DalevaluesCSFM3G';
DalenameCSFM6G='DalevaluesCSFM6G';

DMorphine_blood = xlsread(DalenameBloodM);
DM3G_blood= xlsread(DalenameBloodM3G);
DM6G_blood= xlsread(DalenameBloodM6G);
DMorphine_CSF= xlsread(DalenameCSFM);
DM3G_CSF=xlsread(DalenameCSFM3G);
DM6G_CSF=xlsread(DalenameCSFM6G);

 
% import values from Ingolf Meineke et al. Model journal
% plasma 
MeinekePlasmaM='MeinekeMorphinePlasma.xlsx';
MeinekePlasmaM3G='MeinekeM3GPlasma.xlsx';
MeinekePlasmaM6G='MeinekeM6GPlasma.xlsx';

% CSF
MeinekeCSFM='MeinekeMorphineCSF.xlsx';
MeinekeCSFM3G='MeinekeM3GCSF.xlsx';
MeinekeCSFM6G='MeinekeM6GCSF.xlsx';

MMorphine_blood = xlsread(MeinekePlasmaM);
MM3G_blood= xlsread(MeinekePlasmaM3G);
MM6G_blood= xlsread(MeinekePlasmaM6G);
MMorphine_CSF= xlsread(MeinekeCSFM);
MM3G_CSF= xlsread(MeinekeCSFM3G);
MM6G_CSF= xlsread(MeinekeCSFM6G);
%%

% figure(1);
% plot (t, y(:,1)); 
% xlabel ('Time'); ylabel ('Morphine Surgical Site'); title ('Concentration profile ');
% figure(2);
% plot (t, y(:,2));
% xlabel ('Time'); ylabel ('Morphine liver'); title ('Concentration profile');
% figure(3);
% plot (t, y(:,3)); 
% xlabel ('Time'); ylabel ('Morphine muscle'); title ('Concentration profile');
% figure(4);
% plot (t, y(:,4)); 
% xlabel ('Time'); ylabel ('Morphine blood'); title ('Concentration profile');
% % figure(5);
% plot (t, y(:,5)); 
% xlabel ('Time'); ylabel ('M3G Surgical Site'); title ('Concentration profile');
% figure(6);
% plot (t, y(:,6));
% xlabel ('Time'); ylabel ('M3G liver'); title ('Concentration profile');
% figure(7);
% plot (t, y(:,7)); 
% xlabel ('Time'); ylabel ('M3G muscle'); title ('Concentration profile');
% figure(8);
% plot (t, y(:,8)); 
% xlabel ('Time'); ylabel ('M3G blood'); title ('Concentration profile');
% figure(9)
% plot (t, y(:,9)); 
% xlabel ('Time'); ylabel ('M6G Surgical Site'); title ('Concentration profile');
% figure(10);
% plot (t, y(:,10));
% xlabel ('Time'); ylabel ('M6G liver'); title ('Concentration profile');
% figure(11);
% plot (t, y(:,11)); 
% xlabel ('Time'); ylabel ('M6G muscle'); title ('Concentration profile');
% figure(12);
% plot (t, y(:,12)); 
% xlabel ('Time'); ylabel ('M6G blood'); title ('Concentration profile');
% figure(13);
% plot (t, y(:,13)); 
% xlabel ('Time'); ylabel ('Morphine in Urine'); title ('Concentration profile');
% figure(14);
% plot (t, y(:,14)); 
% xlabel ('Time'); ylabel ('M3G Urine'); title ('Concentration profile');
% figure(15);
% plot (t, y(:,15)); 
% xlabel ('Time'); ylabel ('M6G Urine'); title ('Concentration profile');

% ******************* morphine and compartments including liver and
% metabolites***************************************************

figure(16);
subplot(3,2,1); % plot blood top left corner
plot (t, y(:,4)); 
title('Morphine in Blood');
xlabel('Time (s)');
ylabel('Morphine (nmol/L)');
subplot(3,2,3);
plot(t, y(:,1)); %plot morphine of surgical top right corner
xlabel('Time (s)');
ylabel('Morphine (nmol/L)');
title('Morphine in Surgical');
subplot(3,2,5); %plot morphine in musclie middle left 
plot(t,y(:,3));
title('Morphine Muscle');
xlabel('Time (s)');
ylabel('Morphine (nmol/L)');
subplot(3,2,2); % plot of morphine in Liver
plot(t, y(:,2));
title('Morphine liver');
xlabel('Time (s)');
ylabel('Morphine (nmol/L)');
subplot(3,2,4); %plot of M3G in Liver
plot(t, y(:,6));
title('M3G  Liver');
xlabel('Time (s)');
ylabel('Morphine (nmol/L)');
subplot(3,2,6); % plot of M6G in liver 
plot(t,y(:,10));
title('M6G  Liver');
xlabel('Time (s)');
ylabel('Morphine (nmol/L)');
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

%-----------------------Plot of morphine and its metabolites in blood
figure(20);
subplot(3,1,1); % plot blood top left corner
plot (t, y(:,4)); 
title('Morphine in Blood');
ylabel('Concentration (nmol/L)')
subplot(3,1,2);
plot(t, y(:,8)); %plot m3g of CSF top right corner
title('M3G in Blood');
ylabel('Concentration (nmol/L)')
subplot(3,1,3); %plot morphine in musclie middle left 
plot(t,y(:,12));
title('M6G in Blood');
ylabel('Concentration (nmol/L)')
xlabel('Time (s)');
% ---------------------------Plot of morphine and its metabolits in the Liver
figure(21);
subplot(3,1,1); % plot blood top left corner
plot (t, y(:,2)); 
title('Morphine in Liver');
ylabel('Concentration (nmol/L)')
xlabel('Time (s)');
subplot(3,1,2);
plot(t, y(:,6)); %plot m3g of CSF top right corner
title('M3G in Liver');
ylabel('Concentration (nmol/L)')
xlabel('Time (s)');
subplot(3,1,3); %plot morphine in musclie middle left 
plot(t,y(:,10));
title('M6G in Liver');
ylabel('Concentration (nmol/L)')
xlabel('Time (s)');

% ++++++++++++++++++ PLOT including literature plots++++++++
figure (22); %plot of morphine blood
plot(t,y(:,4)); 
hold on
xvaluesMB=DMorphine_blood(:,1);
yvaluesMB=DMorphine_blood(:,2);
xvalMB=MMorphine_blood(:,1);
yvalMB=MMorphine_blood(:,2);
plot(xvaluesMB,yvaluesMB,'-.mo');
plot(xvalMB,yvalMB, '-.r*')
xlabel('Time (s)');
ylabel('Concentration Morphine (nmol/L)');
title('Plot of morphine in blood literature data vs. model'); 
leg1= legend('Model Morphine in Blood', 'Dale Morphine in Plasma','Meineke Morphine in Plasma');
set(leg1,'FontAngle','italic','TextColor',[.3,.2,.1]);

figure(23); %plot of morphine CSF/surgical site
plot(t, y(:,1)); 
hold on
xvalueMS= DMorphine_CSF(:,1);
yvalueMS= DMorphine_CSF(:,2);
xvalMS= MMorphine_CSF(:,1);
yvalMS= MMorphine_CSF(:,2);
plot(xvalueMS, yvalueMS, '-.mo');
plot(xvalMS,yvalMS, '-.r*');
xlabel('Time (s)'); ylabel('Concentration Morphine (nmol/L)');
title('Plot of morphine in CSF site literature data vs. model'); 
leg2= legend('Model Morphine in CSF', 'Dale Morphine in CSF','Meineke Morphine in CSF');
set(leg2,'TextColor',[.3,.2,.1]);


figure(24); % plot M3G in blood
plot(t, y(:,8));
hold on 
xvalueM3B=DM3G_blood(:,1);
yvalueM3B= DM3G_blood(:,2);
xvalM3B= MM3G_blood(:,1);
yvalM3B= MM3G_blood(:,2); 
plot(xvalueM3B, yvalueM3B, '-.mo');
plot(xvalM3B,yvalM3B, '-.r*');
xlabel('Time (s)'); ylabel('Concentration M3G (nmol/L)');
title('Plot of M3G in blood literature data vs. model'); 
leg2= legend('Model M3G in blood', 'Dale M3G in blood','Meineke M3G in blood');
set(leg2,'TextColor',[.3,.2,.1]);

figure(25); % plot M6G in blood
plot(t, y(:,12));
hold on
xvalueM6B=DM6G_blood(:,1);
yvalueM6B=DM6G_blood(:,2);
xvalM6B=MM6G_blood(:,1);
yvalM6B=MM6G_blood(:,2);
plot(xvalueM6B, yvalueM6B, '-.mo');
plot(xvalM6B,yvalM6B, '-.r*');
xlabel('Time (s)'); ylabel('Concentration M6G (nmol/L)');
title('Plot of M6G in blood literature data vs. model'); 
leg2= legend('Model M6G in blood', 'Dale M6G in blood','Meineke M6G in blood');
set(leg2,'TextColor',[.3,.2,.1]);

figure(26); %plot of M3G in Surgical Site
plot(t,y(:,5));
hold on
xvalueM3S=DM3G_CSF(:,1);
yvalueM3S=DM3G_CSF(:,2);
xvalM3S=MM3G_CSF(:,1);
yvalM3S=MM3G_CSF(:,2);
plot(xvalueM3S, yvalueM3S, '-.mo');
plot(xvalM3S,yvalM3S, '-.r*');
xlabel('Time (s)'); ylabel('Concentration M3G (nmol/L)');
title('Plot of M3G in CSF literature data vs. model'); 
leg2= legend('Model M3G in CSF', 'Dale M3G in CSF','Meineke M3G in CSF');
set(leg2,'TextColor',[.3,.2,.1]);

figure(27); %plot M6G in CSF
plot(t,y(:,9));
hold on
xvaluesM6S=DM6G_CSF(:,1);
yvaluesM6S=DM6G_CSF(:,2);
xvalM6S=MM6G_CSF(:,1);
yvalM6S=MM6G_CSF(:,2);
plot(xvaluesM6S, yvaluesM6S, '-.mo');
plot(xvalM6S,yvalM6S,'-.r*');
xlabel('Time (s)'); ylabel('Concentration M6G (nmol/L)');
title('Plot of M6G in CSF literature data vs. model'); 
leg2= legend('Model M6G in CSF', 'Dale M6G in CSF','Meineke M6G in CSF');
set(leg2,'TextColor',[.3,.2,.1]);



%http://mathbio.colorado.edu/mediawiki/index.php/Substrate-Enzyme_Kinetics
