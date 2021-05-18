function [PSNR,wPSNR]=psnrMetric(a,b,type)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a:
% b:
% type:
% type=1 -> psnr
% type=2 -> nsG
% type=3 -> sgG
% type=4 -> psnr,nsG
% type=5 -> psnr,sgG
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wPSNR=[];
if (a == b)
    out = inf;
else
    if size(a,3) == 3
        a=[a(:,:,1) a(:,:,2) a(:,:,3)]; 
        b=[b(:,:,1) b(:,:,2) b(:,:,3)];
    end    
    if (type>=1 && type<=5)
        if (type==2 || type==4)
            statistics='nsG';
        else
            statistics='sgG';
        end
        NVF = nvf(a,statistics,150);
        NVF = NVF/max(NVF(:));
%         c = NVF.*(a-b).^2;
    end
    c =(double(a) - double(b)).^2;
    PSNR=10*log10(255^2*prod(size(a))/sum(c(:)));
    c = NVF.*c;
    wPSNR=10*log10(255^2*prod(size(a))/sum(c(:)));        
end   