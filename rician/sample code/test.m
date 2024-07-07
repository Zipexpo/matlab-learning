a=imread('cameraman.tif');
name= input('kind of strel exp,trong dau nhay');
d=input('sise of strel: d')
d=5;
se=strel(name,d);
bb=imopen(a,se);
imshow(bb)