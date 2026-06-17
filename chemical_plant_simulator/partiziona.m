function [ind]=partiziona(A,B,nsis,ning)
%
% partiziona un sistema in sottosistemi, la cui dimensione è contenuta nel vettore nsis, stabilizza i sottosistemi
% sulla diagonale e verifica che il sistema retroazionato sia stabile
%
[n,m]=size(B);

% verifica di coerenza delle dinemsioni

ns=max(size(nsis))

nt=ones(1,ns)*nsis



  n1=0;
  nb=0;
  for i=1:ns
      eval(['A' num2str(i) ' = A(n1+1:n1+nsis(i),n1+1:n1+nsis(i))'])
      eval(['A' num2str(i) ' = A(n1+1:n1+nsis(i),nb+1:nb+ning(i))'])
      n1=n1+nsis(i)
      nb=nb+ning(i)
  end
      
ind=0;