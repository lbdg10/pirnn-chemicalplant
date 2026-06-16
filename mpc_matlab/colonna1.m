function xp=colonna1(u,N1,Na1,Ne1,H1,alfa,E)
%
% simulatore colonna
%
% N = numero totale di piatti
% Na = numero di piatti arricchimento
% Ne = numero di piatti di esaurimento
% H = vettore degli hold-up
% alfa = volatilità relativa (costante)
% E = efficienza (costante)
%
% concentrazioni 
%
xa=u(1:N1);
xb=u(N1+1:2*N1);
xc=u(2*N1+1:3*N1);
%xd=u(3*N1+1:4*N1);
%
% riflusso, vapore, portata alimento, concentrazione alimento
%
R=u(3*N1+1);
V=u(3*N1+2);
F=u(3*N1+3);
xfa=u(3*N1+4);
xfb=u(3*N1+5);
xfc=u(3*N1+6);
xfd=u(3*N1+7);
%
% y*
%
aalfa=alfa/alfa(4);
%ysa=aalfa(1)*xa./(1+(aalfa(1)-1)*xa);
%ya(1)=ysa(1);
%ysb=aalfa(2)*xb./(1+(aalfa(2)-1)*xb);
%yb(1)=ysb(1);
%ysc=aalfa(3)*xc./(1+(aalfa(3)-1)*xc);
%yc(1)=ysc(1);
%ysd=alfa(4)*xd./(1+(alfa(4)-1)*xd);
%yd(1)=ysd(1);
ysa=[];
ysb=[];
ysc=[];
for i=1:N1
    xs=1-xa(i)-xb(i)-xc(i);
    A=[1+xa(i)*aalfa(1)/xs xa(i)*aalfa(1)/xs xa(i)*aalfa(1)/xs;...
        xb(i)*aalfa(2)/xs 1+xb(i)*aalfa(2)/xs xb(i)*aalfa(2)/xs;...
        xc(i)*aalfa(3)/xs xc(i)*aalfa(3)/xs 1+xc(i)*aalfa(3)/xs];
    B=[aalfa(1)*xa(i)/xs;aalfa(2)*xb(i)/xs;aalfa(3)*xc(i)/xs];
    Y=inv(A)*B;
    ysa=[ysa;Y(1)];
    ysb=[ysb;Y(2)];
    ysc=[ysc;Y(3)];
end
ya(1)=ysa(1);
yb(1)=ysb(1);
yc(1)=ysc(1);
%
% componente più volatile - vapore
%
for i=2:N1
    ya(i)=ya(i-1)+E*(ysa(i)-ya(i-1));
    yb(i)=yb(i-1)+E*(ysb(i)-yb(i-1));
    yc(i)=yc(i-1)+E*(ysc(i)-yc(i-1));
%    yd(i)=yd(i-1)+E*(ysd(i)-yd(i-1));
end
xpa=[];
xpb=[];
xpc=[];
%xpd=[];
%
% equazione del ribollitore
%
xpa(1)=(1/H1(1))*((R+F)*(xa(2)-xa(1))+V*(xa(1)-ya(1)));
xpb(1)=(1/H1(1))*((R+F)*(xb(2)-xb(1))+V*(xb(1)-yb(1)));
xpc(1)=(1/H1(1))*((R+F)*(xc(2)-xc(1))+V*(xc(1)-yc(1)));
%xpd(1)=(1/H1(1))*((R+F)*(xd(2)-xd(1))+V*(xd(1)-yd(1)));
%
% zona di esaurimento
%
for i=2:Ne1+1
    xpa(i)=(1/H1(i))*((R+F)*(xa(i+1)-xa(i))+V*(ya(i-1)-ya(i)));
    xpb(i)=(1/H1(i))*((R+F)*(xb(i+1)-xb(i))+V*(yb(i-1)-yb(i)));
    xpc(i)=(1/H1(i))*((R+F)*(xc(i+1)-xc(i))+V*(yc(i-1)-yc(i)));
%    xpd(i)=(1/H1(i))*((R+F)*(xd(i+1)-xd(i))+V*(yd(i-1)-yd(i)));
end
%
% piatto di alimentazione
%
xpa(Ne1+2)=(1/H1(Ne1+2))*(R*xa(Ne1+3)-(R+F)*xa(Ne1+2)+V*(ya(Ne1+1)-ya(Ne1+2))+F*xfa);
xpb(Ne1+2)=(1/H1(Ne1+2))*(R*xb(Ne1+3)-(R+F)*xb(Ne1+2)+V*(yb(Ne1+1)-yb(Ne1+2))+F*xfb);
xpc(Ne1+2)=(1/H1(Ne1+2))*(R*xc(Ne1+3)-(R+F)*xc(Ne1+2)+V*(yc(Ne1+1)-yc(Ne1+2))+F*xfc);%
%xpd(Ne1+2)=(1/H1(Ne1+2))*(R*xd(Ne1+3)-(R+F)*xd(Ne1+2)+V*(yd(Ne1+1)-yd(Ne1+2))+F*xfd);
%
% piatti di arricchimento
%
for i=Ne1+3:Ne1+Na1+2
    xpa(i)=(1/H1(i))*(R*(xa(i+1)-xa(i))+V*(ya(i-1)-ya(i)));
    xpb(i)=(1/H1(i))*(R*(xb(i+1)-xb(i))+V*(yb(i-1)-yb(i)));
    xpc(i)=(1/H1(i))*(R*(xc(i+1)-xc(i))+V*(yc(i-1)-yc(i)));
%    xpd(i)=(1/H1(i))*(R*(xd(i+1)-xd(i))+V*(yd(i-1)-yd(i)));
end
%
% condensatore
%
xpa(N1)=(1/H1(N1))*V*(ya(N1-1)-xa(N1));
xpb(N1)=(1/H1(N1))*V*(yb(N1-1)-xb(N1));
xpc(N1)=(1/H1(N1))*V*(yc(N1-1)-xc(N1));
%xpd(N1)=(1/H1(N1))*V*(yd(N1-1)-xd(N1));
%xp=[xpa'; xpb'; xpc'; xpd'];
xp=[xpa'; xpb'; xpc'];