function value = morph(a)

%a=double(imread('mdb209_pec.pgm'));
%wieghted average filter
k = [1 2 1;2 4 2;1 2 1]./16;
f = (conv2(a,k,'same'));

%%%%%%%%%%
% sigma=200; %120
% A=im2single(a);
% % Symmetric image padding is used over here
% blurredimg = imgaussfilt(A,sigma,'padding','symmetric','filtersize',2*ceil(2*sigma)+1);
% output=A*mean(A(:),'omitnan')./blurredimg; % mean of A, not of blurred image
% %output=im2uint8(output);
% f =output;
% Iblurred = imgaussfilt(a,4);
% filterStrength = 80;
% weights = fspecial('gaussian',[size(a,1) size(a,2)],filterStrength);
% weights = rescale(weights);
% f = a.*weights + Iblurred.*(1-weights);
%background
%f2 = a-f;    % High pass filtre 
% 3/5<=aa<=5/6  =3/5;
aa=3/5;
%f2 = (aa/(aa-1))*a-(1/(aa-1))*f;% (5/4)*a-(1/4)*f;    % High boot filtre 
f2 = (aa/(2*aa-1))*a-((1-aa)/(2*aa-1))*f;
se = strel('disk',10);%10
%se = strel('square',3);
%se = strel('cube',5);

%% top hat %%
b = imtophat(f,se);

%% bottom hat %%
c = imbothat(f,se);

e = f + b - c;
 %%%%%%%%%%%%L
%  bf=Bilateral(a,5,3,.1);
%  out = Butterworth(bf,120);
%  k=0.8;%1.5;
%  f2=a+ k.*(a-out); %double

% se1 = strel('disk',20); %15
% background = imopen(a,se1);
% figure(2); imshow(background)
% %image has a uniform background but is now a bit dark for analysis.
% I2 = a - background;
% %Use imadjust to increase the contrast
% f2 = imadjust(I2);
% f4=imgaussfilt(f3,2);%imbilatfilt(f2);
% f2=f3-f4;

%f2=wiener2(f2);%medfilt2(f2); %tot 61,9069

%f2 = imdiffusefilt(f2);

%f2=wlsFilter(f2,2,2);
% tr=mean(f2(:));

% %  [m n]=size(f2);
% %  for i=1:m
% %      for j=1:n
% %             e(i,j) = 1/9*(8*b(i,j) - (b(i-1,j-1) + b(i-1,j) + b(i-1,j+1)...
% %               + b(i,j-1) + b(i,j+1) + b(i+1,j-1) + b(i+1,j) + b(i+1,j+1)));
% % %         tam=f2(i,j);
% % %         if tam<tr
% % %             f3(i,j)=0.1*f2(i,j);
% % %         else
% % %               f3(i,j)=2*f2(i,j);
% % %         end
% %      end
% % end 
% %   hh=[-1 -1 -1; -1 8  -1; -1 -1 -1]./16;%9; %8 high pass
% %   f2=conv2(f2,hh,'same');    
% value = f3 + e;
%figure(10); imshow(mat2gray(value))

%%%%%%%%%%%%%%%%%%%%%%%%
value = f2 + e;
