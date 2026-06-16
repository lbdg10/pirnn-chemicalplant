%%%%%%%%%%%%%%%%%%%%%%%%%
% dati reattore 1
%%%%%%%%%%%%%%%%%%%%%%%%%
k1=10;
VR1=1000;
%
% ingressi
%
F0A=100;
z0A_a=1;
z0A_b=0;
z0A_c=0;
z0A_d=0;
%
D1=80;
xD1_a=0.7381;
xD1_b=0.2119;
xD1_c=0.05;
xD1_d=0;
%
D3=141;
xD3_a=0.;
xD3_b=0.7147;
xD3_c=0.0036;
xD3_d=0.2817;
%
F0B=0.5;
z0B_a=0;
z0B_b=1;
z0B_c=0;
z0B_d=0;
%
% presunti equilibri
%
z1a=0.184;
z1b=0.0544;
z1c=0.3255;
z1d=0.4361;


%%%%%%%%%%%%%%%%%%%%%%%%%
% dati colonna 1
%%%%%%%%%%%%%%%%%%%%%%%%%
%
% volatilita' relativa (costante per ogni piatto)
% efficienza (costante in ogni piatto)
%
alfaa=8;
alfab=6;
alfac=4;
alfad=2;
alfae=1.2;
alfaf=1;
alfa=[alfaa alfab alfac alfad alfae alfaf];
% numero piatti di arricchimento (Na) ed esaurimento (Ne)
%
Na1=3;
Ne1=3;
%
% N =numero totale piatti
% piatto 1 = ribollitore, piatto N = condensatore
%
N1=Na1+Ne1+3;
%
% hold up liquido
%
Hr1=53.8; % ribollitore
Hc1=33.6; % condensatore
Ha1=1.36; % arricchimento
He1=1.63; % esaurimento
Hf1=1.36; % alimentazione

H1=[Hr1;He1*ones(Ne1,1);Hf1;Ha1*ones(Na1,1);Hc1];

%
% inizializzazione concentrazioni
%
x1a=zeros(N1,1);
x1b=zeros(N1,1);
x1c=zeros(N1,1);
x1d=zeros(N1,1);

x1a(1)=0.0;
x1a(N1)=0.7381;
x1b(1)=0.0021;
x1b(N1)=0.2119;
x1c(1)=0.4170;
x1c(N1)=0.05;
x1d(1)=0.5809;
x1d(N1)=0.0;

for i=2:N1-1
    x1a(i)=(1/(N1-1))*((x1a(N1)-x1a(1))*i+x1a(1)*N1-x1a(N1));
    x1b(i)=(1/(N1-1))*((x1b(N1)-x1b(1))*i+x1b(1)*N1-x1b(N1));
    x1c(i)=(1/(N1-1))*((x1c(N1)-x1c(1))*i+x1c(1)*N1-x1c(N1));
    x1d(i)=(1/(N1-1))*((x1d(N1)-x1d(1))*i+x1d(1)*N1-x1d(N1));
end
%
% ingressi nominali
%
R1=330;
V1=330+80;

%
%%%%%%%%%%%%%%%%%%%%%%%%%
% dati colonna 2
%%%%%%%%%%%%%%%%%%%%%%%%%

% numero piatti di arricchimento (Na) ed esaurimento (Ne)
%
Na2=3;
Ne2=3;
%
% N =numero totale piatti
% piatto 1 = ribollitore, piatto N = condensatore
%
N2=Na2+Ne2+3;
%
% hold up liquido
%
Hr2=100; % ribollitore
Hc2=32.1; % condensatore
Ha2=1.27; % arricchimento
He2=1.39; % esaurimento
Hf2=1.27; % alimentazione

H2=[Hr2;He2*ones(Ne2,1);Hf2;Ha2*ones(Na2,1);Hc2];

%
% inizializzazione concentrazioni
%
x2a=zeros(N2,1);
x2b=zeros(N2,1);
x2c=zeros(N2,1);
x2d=zeros(N2,1);

x2a(1)=0.00;
x2a(N2)=0.001;
x2b(1)=0.0;
x2b(N2)=0.0049;
x2c(1)=0.0036;
x2c(N2)=0.9851;
x2d(1)=0.9964;
x2d(N2)=0.01;

for i=2:N2-1
    x2a(i)=(1/(N2-1))*((x2a(N2)-x2a(1))*i+x2a(1)*N2-x2a(N2));
    x2b(i)=(1/(N2-1))*((x2b(N2)-x2b(1))*i+x2b(1)*N2-x2b(N2));
    x2c(i)=(1/(N2-1))*((x2c(N2)-x2c(1))*i+x2c(1)*N2-x2c(N2));
    x2d(i)=(1/(N2-1))*((x2d(N2)-x2d(1))*i+x2d(1)*N2-x2d(N2));
end
%
% ingressi nominali
%
R2=283;
V2=385;

%
%%%%%%%%%%%%%%%%%%%%%%%%%
% dati reattore 2
%%%%%%%%%%%%%%%%%%%%%%%%%

k2=50;
VR2=850;
%
% ingressi
%
F0E=99.5;
z0E_d=0;
z0E_e=1;
z0E_f=0;
z0E_b=0;

z2d=0.0514;
z2e=0.0411;
z2f=0.4455;
z2b=0.4455;

%%%%%%%%%%%%%%%%%%%%%%%%%
% dati reattore 3
%%%%%%%%%%%%%%%%%%%%%%%%%

z3d=0.0523;
z3e=0.0032;
z3f=0.4666;
z3b=0.4666;


%
%%%%%%%%%%%%%%%%%%%%%%%%%
% dati colonna 3
%%%%%%%%%%%%%%%%%%%%%%%%%

E=1;%
% numero piatti di arricchimento (Na) ed esaurimento (Ne)
%
Na3=3;
Ne3=3;
%
% N =numero totale piatti
% piatto 1 = ribollitore, piatto N = condensatore
%
N3=Na3+Ne3+3;
%
% hold up liquido
%
Hr3=31.7; % ribollitore
Hc3=100; % condensatore
Ha3=0.837; % arricchimento
He3=1.04; % esaurimento
Hf3=1.04; % alimentazione

H3=[Hr3;He3*ones(Ne3,1);Hf3;Ha3*ones(Na3,1);Hc3];

%
% inizializzazione concentrazioni
%
x3a=zeros(N3,1);
x3b=zeros(N3,1);
x3c=zeros(N3,1);
x3d=zeros(N3,1);

x3a(1)=0.00001;
x3a(N3)=0.72;
x3b(1)=0.001;
x3b(N3)=0.275;
x3c(1)=0.00001;
x3c(N3)=0.0001;
x3d(1)=0.99;
x3d(N3)=0.000001;

for i=2:N3-1
    x3a(i)=(1/(N3-1))*((x3a(N3)-x3a(1))*i+x3a(1)*N3-x3a(N3));
    x3b(i)=(1/(N3-1))*((x3b(N3)-x3b(1))*i+x3b(1)*N3-x3b(N3));
    x3c(i)=(1/(N3-1))*((x3c(N3)-x3c(1))*i+x3c(1)*N3-x3c(N3));
    x3d(i)=(1/(N3-1))*((x3d(N3)-x3d(1))*i+x3d(1)*N3-x3d(N3));
end
%
% ingressi nominali
%
R3=141;
V3=282;


%% Cambio solo R
DR1 = +(V1-R1)-10;
DR2 = +(V2-R2)-10;
DR3 = +(V3-R3)-10;
R1= R1+DR1;
R2= R2+DR2;
R3= R3+DR3;
D1 = V1-R1;
D2 = V2-R2;
D3 = V3-R3;