function Th=ShrinkThresholding(X,C,S,NameShrink)
%%Input:
%X:Data
%C,S wavedec2 su dung trong main program
%NameShrink: 1: Bayer;2 :VisuShrink;3: SureShrink;4:Heuristic varian; 5:Conventional Threshold
%%Output: Threshold

% Estimated noisy variance
[r c]=size(X)
if r~=1
x=reshape(X,[1,r*c]);
else
x=X;
end 
var=length(C)-S(size(S,1)-1,1)^2+1;  %bat dau cua D1
sigma=median(abs(C(var:length(C))))/0.6745;

switch NameShrink
    case 1 %BayerShrink
        len=numel(x);
        sigmay2=sum(x.^2)/len;
        sigmax=sqrt(max(sigmay2-sigma^2,0));
        if sigmax==0 Th=max(abs(x));
        else Th=sigma^2/sigmax;
        end
        
    case 2 %VisuShrink
        
        Th=sigma*sqrt(2*log(numel(x))); %thselect la 'sqtwolog';
            
    case 3 %SureShrink
        
        Th = thselect(x,'rigrsure'); %thselect: ham Matlab
 
     case 4 %Heuristic variant of 'rigrsure' and 'sqtwolog'.
         
        Th = thselect(x,'heursure'); 
    
    case 5  %Conventional Threshold
        
        Th = sqrt(2*log(numel(x)));
end