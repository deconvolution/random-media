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
rng(1)
W=randn(nx,ny,nz);

% sampling interval
ksx=1/dx;
ksy=1/dy;
ksz=1/dz;

nkx=500;
nky=500;
nkz=500;

kx=ksx*((-nkx/2):(nkx/2))/nkx;
ky=ksx*((-nky/2):(nky/2))/nky;
kz=ksx*((-nkz/2):(nkz/2))/nkz;

kx=kx(2:end);
ky=ky(2:end);
kz=kz(2:end);

Lx=nx;
Ly=ny;
Lz=nz;

FW=fftn(W,[nkx,nky,nkz]);
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
pcolor3(real(t),'alpha',.1)
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
