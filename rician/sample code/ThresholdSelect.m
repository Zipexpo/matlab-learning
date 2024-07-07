function Th=ThresholdSelect(X,NameShrink)
%%Input:
%C,S la2 wavedec2
%X:Data la H,V ,D lay tu C cho tung muc
%NameShrink: 1: Bayer;2 :VisuShrink;3: SureShrink;4:Heuristic varian;
% 5:Conventional Threshold or 'sqtwolog';6: MiniMaxi threshold 
%%Output: Th: Threshold

% Estimated noisy variance
[r c]=size(X);
if r~=1
x=reshape(X,[1,r*c]);
else
x=X;
end 
sigma=median(abs(x))/0.6745;

switch NameShrink
    case 1 %BayerShrink
        len=numel(x);
        sigmay2=sum(x.^2)/len;
        sigmax=sqrt(max(sigmay2-sigma^2,0));
        if sigmax==0 Th=max(abs(x));
        else Th=sigma^2/sigmax;
        end
        
    case 2 %VisuShrink or Universal
        
        Th=sigma*sqrt(2*log(numel(x))); %thselect la 'sqtwolog';
            
    case 3 %SureShrink
        
        Th = thselect(x,'rigrsure'); %thselect: ham Matlab
 
     case 4 %Heuristic variant of 'rigrsure' and 'sqtwolog'.
         
        Th = thselect(x,'heursure'); 
    case 5 %sqtwolog or conventional
      
        Th = thselect(x,'sqtwolog'); % fix form of Universal or Conventional threshold
        
    case 6 %   'minimaxi' 
        
        Th=thselect(x,'minimaxi'); %Minimax thresholding.

    
   
end