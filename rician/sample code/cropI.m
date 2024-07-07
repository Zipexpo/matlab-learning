function I2 = cropI(img)
%%CROP image%%
[R,C] = size(img);
s = sum(img);

for i = 1:R
    if s(i) > 0
        x = i;
        break;
    end
end
x
for i = R:-1:x
    if s(i) > 0
        y = i;
        break;
    end
end
y
endpx = R - y;
width = R - x - endpx;
I2 = imcrop(img,[x 0 width 1024]);