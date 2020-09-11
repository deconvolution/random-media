function FF=R2(kx,kz)
[kx2,kz2]=meshgrid(kx,kz);
FF=zeros(size(kx2));
k=sqrt(kx2.^2+kz2.^2);

%%

% von karman

k2=1;
a=50;
d=2;
N=-.1;
FF=k2.^2*(a.^-2+k.^2).^(-d/4-N/2);

%{
% gaussian
kappa=100;
ag=10;
FF=kappa.*exp(-ag.^2.*k.^2/8);
%}
end