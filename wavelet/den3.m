

s1 = double(imread('Tumor3_Skull_Tripped.jpg'));
s = s1(:,:);
x = s + 20*randn(size(s));
t = 0:5:50;         % threshold range(0~50),increment by 5
e = den2(s,x,t);    % using standard method
re = rden2(s,x,t);  % using reduced 2-D dual-tree method 
ce = cden2(s,x,t);  % using complex 2-D dual-tree method

figure(1)
plot(t,e)
hold on
plot(t,re,'r')
hold on
plot(t,ce,'k')
title('RMS error V.S. Threshold Pt.') 
xlabel('Threshold pt.');
ylabel('RMS error');
legend('Standard 2D','Reduced 2D dual','Complx 2D dual');


[emin,k] = min(e);
T = t(k);
y = denS2D(x,T);
figure(2)
clf
imagesc(y/4)
colormap gray;
axis square
axis off
print -deps den3_A

ax = [280*[1 1] 250*[1 1]]+[0 1 0 1]*120;

figure(3)
clf
imagesc(y/4)
colormap gray;
axis(ax)
axis square
axis off
print -deps den3_B

[emin,k] = min(ce);
T = t(k);
y = denC2D(x,T);
figure(4)
clf
imagesc(y/4)
colormap gray;
axis image
axis off
print -deps cden3_A

figure(5)
clf
imagesc(y/4)
colormap gray;
axis(ax)
axis square
axis off
print -deps cden3_B

