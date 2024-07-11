clear all
close all
clc

tic
x=imread("Tumor2447_Skull_Tripped.jpg"); %('Tumor4 Skull Tripped.png');% ('Tumor3_Skull_Tripped.png');%imread('mdb_pr002.pgm');%rgb2gray(imread('Malignant case (52).jpg
figure(1), imshow(x)
x1=imnoise(x,'Gaussian', 0.02);
psnr_noi=psnr(x1,x)
figure(2), imshow(x1)
t = wpdec2(double(x),1,'sym4');
%figure; plot(t);
% Change Node Label from Depth_position to Index and
% click the node (0). You get the following plot
	% Global thresholding.
	% t1 = t;
	% sorh = 'h';
	% thr = wthrmngr('wp1ddenoGBL','penalhi',t);
	% cfs = read(t,'data');
	% cfs = wthresh(cfs,sorh,thr);
	% t1  = write(t1,'data',cfs);
	% plot(t1)
	
	% Change Node Label from Depth_position to Index and
	% click the node (0). You get the following plot.
	
% Node by node thresholding. 
t2 = t;
sorh = 's';
% thr(1) = wthrmngr('wp1ddenoGBL','penalhi',t)
% thr(2) = wthrmngr('wp1ddenoGBL','sqtwologswn',t)
tn  = leaves(t);
for k=1:length(tn)
  node = tn(k);
  if node ~=1
  cfs1 = read(t,'data',node); %khg morph cfs
  thr = thselect(cfs1(:),'rigrsure');
  %numthr = rem(node,2)+1;
  cfs = cfs1;%morph(cfs1); %them do tuong phan 48.26 , morph 48,09 ding wigted average ,hist con 37
  cfs = wthresh(cfs,sorh,thr);
 % cfs=medfilt2(uint8(cfs1));
  %[h,k]=hist((cfs));
  else
    cfs = read(t,'data',node);    
  end
  t2 = write(t2,'data',node,cfs);
end	
%figure, plot(t2);	
y=wprec2(t2);
figure; imshow(mat2gray(y))
psnr_de = psnr(uint8(y),x)
% % Change Node Label from Depth_position to Index and
% % click the node (0). You get the following plot.
 toc
 % [h,k]=imhist(uint8(y));
 % figure, plot(k(5:end-5),h(5:end-5))
 % q=wpdec(h,2,'sym4')