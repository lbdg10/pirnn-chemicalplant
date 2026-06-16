function xp=R3_stati(u,k2,VR2)
%
% simulatore reattore R3
%
z3d=u(1);
z3e=u(2);
z3f=u(3);
z3b=u(4);
%
F=u(5);
z2d=u(6);
z2e=u(7);
z2f=u(8);
z2b=u(9);
%
xp(1)=((z2d*F-F*z3d)/VR2)-k2*z3d*z3e;
xp(2)=((z2e*F-F*z3e)/VR2)-k2*z3d*z3e;
xp(3)=((z2f*F-F*z3f)/VR2)+k2*z3d*z3e;
xp(4)=((z2b*F-F*z3b)/VR2)+k2*z3d*z3e;