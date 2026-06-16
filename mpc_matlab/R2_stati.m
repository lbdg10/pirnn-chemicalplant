function xp=R2_stati(u,k2,VR2)
%
% simulatore reattore R2
%
z2d=u(1);
z2e=u(2);
z2f=u(3);
z2b=u(4);
%
B2D=u(5);
xb2d=u(6);
xb2e=u(7);
xb2f=u(8);
xb2b=u(9);
F0E=u(10);
z0Ed=u(11);
z0Ee=u(12);
z0Ef=u(13);
z0Eb=u(14);
%
f1=B2D+F0E;
%
xp(1)=((xb2d*B2D+F0E*z0Ed-f1*z2d)/VR2)-k2*z2d*z2e;
xp(2)=((xb2e*B2D+F0E*z0Ee-f1*z2e)/VR2)-k2*z2d*z2e;
xp(3)=((xb2f*B2D+F0E*z0Ef-f1*z2f)/VR2)+k2*z2d*z2e;
xp(4)=((xb2b*B2D+F0E*z0Eb-f1*z2b)/VR2)+k2*z2d*z2e;