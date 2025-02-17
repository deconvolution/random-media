clear all;
close all;
%% dimensions
nx=101;
ny=81;
nz=51;
rho=ones(nx,ny,nz)*1000;
nt=600;
dx=10;
dy=10;
dz=10;
dt=2*10^-3;
%% background velocity
v0=ones(nx,ny,nz)*1000;
%% create normal distributed W
rng(2)
W=randn(nx,ny,nz);

% sampling interval
ksx=1/dx;
ksy=1/dy;
ksz=1/dz;

nkx=nx*2;
nky=ny*2;
nkz=nz*2;

kx=ksx*(0:floor(nkx/2)-1)/nkx;
ky=ksy*(0:floor(nky/2)-1)/nky;
kz=ksz*(0:floor(nkz/2)-1)/nkz;


FW=fftn(W,[nkx,nky,nkz]);
FW=FW(1:floor(nkx/2),1:floor(nky/2),1:floor(nkz/2))*2;
%% spectral filter
FF=R2(kx,ky,kz);
Fv=FF.*FW;
%% spacial domain of FF
F=ifftn(FF);
%% inverse transform of velocity in frequency domain
v=real(ifftn(Fv,[nkx,nky,nkz]));
%% background + fluctuation
v=v0+v(1:nx,1:ny,1:nz);
%% pcolor
figure(1)
t=permute(v,[2,1,3]);
colorbar
xlabel({['x*' num2str(dx) '[m]']});
ylabel({['y*' num2str(dy) '[m]']});
zlabel({['z*' num2str(dz) '[m]']});
title('\rho [kg/m^3]');
shg;
%%
figure
zl=10;
imagesc(t(:,:,zl));
xlabel({['x*' num2str(dx) '[m]']});
ylabel({['y*' num2str(dy) '[m]']});
title({['\rho [kg/m^3]'],['z=' num2str(zl*dz) 'm']});
colorbar;
%%
var(v(:))
%% vp
rho=v;
save('rho.mat','rho');
%% vs

v0=ones(nx,ny,nz)*900;
v=v0+v(1:nx,1:ny,1:nz);
vs=v;
save('vs.mat','vs');
