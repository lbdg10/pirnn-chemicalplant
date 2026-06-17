%%%%%%%%%%%%%%%%%%%%%%%%%
% data Reactor 1
%%%%%%%%%%%%%%%%%%%%%%%%%
k1=10;
VR1=1000;
%
% inputs
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
% initial guess on equilibria (initialization of the integrators)
%
z1a=0.184;
z1b=0.0544;
z1c=0.3255;
z1d=0.4361;


%%%%%%%%%%%%%%%%%%%%%%%%%
% data Column 1
%%%%%%%%%%%%%%%%%%%%%%%%%
%
% relative volatilities of the components
% efficiencies
%
alfaa=8;
alfab=6;
alfac=4;
alfad=2;
alfae=1.2;
alfaf=1;
alfa=[alfaa alfab alfac alfad alfae alfaf];
E=1;
%
% number of trays in the enriching (Na) and stripping (Ne) sections
%
Na1=8;
Ne1=8;
%
% N = total number of trays
% tray 1 = reboiler, tray N = condenser
%
N1=Na1+Ne1+3;
%
% liquid hold up
%
Hr1=53.8; % reboiler
Hc1=33.6; % condenser
Ha1=1.36; % enriching
He1=1.63; % stripping
Hf1=1.36; % feed

H1=[Hr1;He1*ones(Ne1,1);Hf1;Ha1*ones(Na1,1);Hc1];

%
% initial values of the molar fractions (initialize the integrators)
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
% nominal inputs
%
R1=330;
V1=330+80;

%
%%%%%%%%%%%%%%%%%%%%%%%%%
% data Column 2
%%%%%%%%%%%%%%%%%%%%%%%%%

E=1;
%
% number of trays in the enriching (Na) and stripping (Ne) sections
%
Na2=8;
Ne2=8;
%
% N = total number of trays
% tray 1 = reboiler, tray N = condenser
%
N2=Na2+Ne2+3;
%
% liquid hold up
%
Hr2=100; % reboiler
Hc2=32.1; % condenser
Ha2=1.27; % enriching
He2=1.39; % stripping
Hf2=1.27; % feed

H2=[Hr2;He2*ones(Ne2,1);Hf2;Ha2*ones(Na2,1);Hc2];

%
% initial values of the molar fractions (initialize the integrators)
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
% nominal inputs
%
R2=283;
V2=385;

%
%%%%%%%%%%%%%%%%%%%%%%%%%
% data Reactor 1
%%%%%%%%%%%%%%%%%%%%%%%%%

k2=50;
VR2=850;
%
% inputs
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
% data Reactor 3
%%%%%%%%%%%%%%%%%%%%%%%%%

z3d=0.0523;
z3e=0.0032;
z3f=0.4666;
z3b=0.4666;


%
%%%%%%%%%%%%%%%%%%%%%%%%%
% data Column 3
%%%%%%%%%%%%%%%%%%%%%%%%%

E=1;
%
% number of trays in the enriching (Na) and stripping (Ne) sections
%
Na3=8;
Ne3=8;
%
% N = total number of trays
% tray 1 = reboiler, tray N = condenser
%
N3=Na3+Ne3+3;
%
% liquid hold up
%
Hr3=31.7; % reboiler
Hc3=100; % condenser
Ha3=0.837; % enriching
He3=1.04; % stripping
Hf3=1.04; % feed

H3=[Hr3;He3*ones(Ne3,1);Hf3;Ha3*ones(Na3,1);Hc3];

%
% initial values of the molar fractions (initialize the integrators)
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
% nominal inputs
%
R3=141;
V3=282;

