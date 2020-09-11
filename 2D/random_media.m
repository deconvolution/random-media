clear all;
close all;
%% dimensions
nx=201;
nz=101;
C=zeros(6,6,nx,nz);
C(1,1,:,:)=1000*1500^2; % P-wave modulus
C(2,2,:,:)=1000*1500^2;
C(3,3,:,:)=1000*1500^2;
C(4,4,:,:)=1000*900^2; % S-wave modulus
C(5,5,:,:)=1000*900^2;
C(6,6,:,:)=1000*900^2;
C(1,2,:,:)=630000000;
C(1,3,:,:)=630000000;
C(2,3,:,:)=630000000;
rho=ones(nx,nz)*1000;
[~,~,nx,nz]=size(C);
nt=600;
dx=10;
dz=10;
dt=2*10^-3;
%% background velocitz
v0=ones(nx,nz)*1000;
%% create normal distributed W
rng(1)
W=randn(nx,nz);

% sampling interval
ksx=1/dx;
ksz=1/dz;

nkx=1000;
nkz=1000;

kx=ksx*((-nkx/2):(nkx/2))/nkx;
kz=ksx*((-nkz/2):(nkz/2))/nkz;

kx=kx(2:end);
kz=kz(2:end);

Lx=nx;
Lz=nz;

FW=fftn(W,[nkx,nkz]);
%% spectral filter
FF=R2(kx,kz);
Fv=FF.*FW;
%% spacial domain of FF
F=ifftn(FF);
%% inverse transform of velocitz in frequencz domain
v=real(ifftn(Fv,[nkx,nkz]));
%% background + fluctuation
vs=v0+v(1:nx,1:nz);
%% pcolor
figure
imagesc(vs);
xlabel({['x*' num2str(dx) '[m]']});
xlabel({['z*' num2str(dz) '[m]']});
title('vs [m/s]');
colorbar;
save('vs.mat','vs');