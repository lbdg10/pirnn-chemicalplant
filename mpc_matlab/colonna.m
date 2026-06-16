function xp=colonna(u,N,Na,Ne,H,alfa,E)
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
x=u(1:N);
%
% riflusso, vapore, portata alimento, concentrazione alimento
%
R=u(N+1);
V=u(N+2);
F=u(N+3);
xf=u(N+4);
%
% y*
%
ys=alfa*x./(1+(alfa-1)*x);
y(1)=ys(1);
%
% componente più volatile - vapore
%
for i=2:N
    y(i)=y(i-1)+E*(ys(i)-y(i-1));
end
xp=[];
%
% equazione del ribollitore
%
xp(1)=(1/H(1))*((R+F)*(x(2)-x(1))+V*(x(1)-y(1)));
%
% zona di esaurimento
%
for i=2:Ne+1
    xp(i)=(1/H(i))*((R+F)*(x(i+1)-x(i))+V*(y(i-1)-y(i)));
end
%
% piatto di alimentazione
%
xp(Ne+2)=(1/H(Ne+2))*(R*x(Ne+3)-(R+F)*x(Ne+2)+V*(y(Ne+1)-y(Ne+2))+F*xf);
%
% piatti di arricchimento
%
for i=Ne+3:Ne+Na+2
    xp(i)=(1/H(i))*(R*(x(i+1)-x(i))+V*(y(i-1)-y(i)));
end
%
% condensatore
%
xp(N)=(1/H(N))*V*(y(N-1)-x(N));