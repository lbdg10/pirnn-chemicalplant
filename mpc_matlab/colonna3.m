function xp=colonna3(u,N3,Na3,Ne3,H3,alfa,E)
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
xa=u(1:N3);
xb=u(N3+1:2*N3);
xc=u(2*N3+1:3*N3);
%xd=u(3*N1+1:4*N1);
%
% riflusso, vapore, portata alimento, concentrazione alimento
%
R=u(3*N3+1);
V=u(3*N3+2);
F=u(3*N3+3);
xfa=u(3*N3+4);
xfb=u(3*N3+5);
xfc=u(3*N3+6);
xfd=u(3*N3+7);
%
% y*
%
aalfa=alfa/alfa(6);
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
for i=1:N3
    xs=1-xa(i)-xb(i)-xc(i);
    A=[1+xa(i)*aalfa(2)/xs xa(i)*aalfa(2)/xs xa(i)*aalfa(2)/xs;...
        xb(i)*aalfa(4)/xs 1+xb(i)*aalfa(4)/xs xb(i)*aalfa(4)/xs;...
        xc(i)*aalfa(5)/xs xc(i)*aalfa(5)/xs 1+xc(i)*aalfa(5)/xs];
    B=[aalfa(2)*xa(i)/xs;aalfa(4)*xb(i)/xs;aalfa(5)*xc(i)/xs];
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
for i=2:N3
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
xpa(1)=(1/H3(1))*((R+F)*(xa(2)-xa(1))+V*(xa(1)-ya(1)));
xpb(1)=(1/H3(1))*((R+F)*(xb(2)-xb(1))+V*(xb(1)-yb(1)));
xpc(1)=(1/H3(1))*((R+F)*(xc(2)-xc(1))+V*(xc(1)-yc(1)));
%xpd(1)=(1/H1(1))*((R+F)*(xd(2)-xd(1))+V*(xd(1)-yd(1)));
%
% zona di esaurimento
%
for i=2:Ne3+1
    xpa(i)=(1/H3(i))*((R+F)*(xa(i+1)-xa(i))+V*(ya(i-1)-ya(i)));
    xpb(i)=(1/H3(i))*((R+F)*(xb(i+1)-xb(i))+V*(yb(i-1)-yb(i)));
    xpc(i)=(1/H3(i))*((R+F)*(xc(i+1)-xc(i))+V*(yc(i-1)-yc(i)));
%    xpd(i)=(1/H1(i))*((R+F)*(xd(i+1)-xd(i))+V*(yd(i-1)-yd(i)));
end
%
% piatto di alimentazione
%
xpa(Ne3+2)=(1/H3(Ne3+2))*(R*xa(Ne3+3)-(R+F)*xa(Ne3+2)+V*(ya(Ne3+1)-ya(Ne3+2))+F*xfa);
xpb(Ne3+2)=(1/H3(Ne3+2))*(R*xb(Ne3+3)-(R+F)*xb(Ne3+2)+V*(yb(Ne3+1)-yb(Ne3+2))+F*xfb);
xpc(Ne3+2)=(1/H3(Ne3+2))*(R*xc(Ne3+3)-(R+F)*xc(Ne3+2)+V*(yc(Ne3+1)-yc(Ne3+2))+F*xfc);%
%xpd(Ne1+2)=(1/H1(Ne1+2))*(R*xd(Ne1+3)-(R+F)*xd(Ne1+2)+V*(yd(Ne1+1)-yd(Ne1+2))+F*xfd);
%
% piatti di arricchimento
%
for i=Ne3+3:Ne3+Na3+2
    xpa(i)=(1/H3(i))*(R*(xa(i+1)-xa(i))+V*(ya(i-1)-ya(i)));
    xpb(i)=(1/H3(i))*(R*(xb(i+1)-xb(i))+V*(yb(i-1)-yb(i)));
    xpc(i)=(1/H3(i))*(R*(xc(i+1)-xc(i))+V*(yc(i-1)-yc(i)));
%    xpd(i)=(1/H1(i))*(R*(xd(i+1)-xd(i))+V*(yd(i-1)-yd(i)));
end
%
% condensatore
%
xpa(N3)=(1/H3(N3))*V*(ya(N3-1)-xa(N3));
xpb(N3)=(1/H3(N3))*V*(yb(N3-1)-xb(N3));
xpc(N3)=(1/H3(N3))*V*(yc(N3-1)-xc(N3));
%xpd(N1)=(1/H1(N1))*V*(yd(N1-1)-xd(N1));
%xp=[xpa'; xpb'; xpc'; xpd'];
xp=[xpa'; xpb'; xpc'];