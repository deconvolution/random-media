function FF=R2(kx,ky,kz)
[kx2,ky2,kz2]=meshgrid(kx,ky,kz);
FF=zeros(size(kx2));
k=sqrt(kx2.^2+ky2.^2+kz2.^2);

%%

% von karman

k2=1;
a=20;
d=3;
N=-.2;
FF=k2.^2*(a.^-2+k.^2).^(-d/4-N/2);

%{
% gaussian
kappa=2;
ag=1;
FF=kappa.*exp(-ag.^2.*k.^2/8);
%}
end