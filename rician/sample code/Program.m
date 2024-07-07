close all
clear all
clc

I = imgetfile();
Io = imread(I);
figure, imshow(Io), title('Original Image');

%%Add noise to image
I_noised = Inoised(Io);
noised = uint8(I_noised);
figure, imshow(mat2gray(I_noised)), title('Noised Image');
[psnr1, snr1] = psnr(noised, Io);
psnr1

%% PreProcess
preprocessed = preprocess(I_noised);
preprocess = uint8(preprocessed);
figure, imshow(mat2gray(preprocessed)), title('preProcesed Image');

%% Wavelet denoising
denoisedImage = denoise(preprocessed);
denoised = uint8(denoisedImage);
figure, imshow(mat2gray(denoisedImage)), title('Wavelet Transformation');

[psnr2, snr2] = psnr(denoised, preprocess);

%% Guided filter
Ismooth = imguidedfilter(denoisedImage);
%Ismooth = imdiffusefilt(denoisedImage);
I_smooth = uint8(Ismooth);
figure,imshow(mat2gray(Ismooth)),title('Guided Image');
[psnr3, snr3] = psnr(I_smooth, preprocess);
psnr2
psnr3
% figure, imhist(Ismooth) %chon nguong
% figure,imshow(im2bw(Ismooth,225/255))
%%Crop Image
% crop_I = cropI(Ismooth);
% figure,imshow(crop_I),title('Crop Image');

%MATLAB TOT Denoise image using deep neural network
% net = denoisingNetwork('DnCNN');
% denoisedI = denoiseImage(preprocessed,net);
% figure,mshow(denoisedI)
%%%%%%%%%%%


save('project.mat','psnr1', 'psnr2', 'psnr3')