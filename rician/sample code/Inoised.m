function I_noised = Inoised(image)

ss = menu('Select the amount of niose add in dB','2 dB', '5 dB', '8 dB');
switch ss
    case 1
        SNR = 2';
    case 2
        SNR = 5;
    case 3
        SNR = 8;
end

%%Add noise to image
Im = double(image)/255;
v = var(Im(:))/10^(SNR/10);
x = menu('Select a noise', 'Gaussian', 'SNR');

switch x
    case 1
        I_noised = imnoise(image,'gaussian', 0.02);
    case 2
        I_noised = imnoise(Im, 'gaussian', 0, v);
end
