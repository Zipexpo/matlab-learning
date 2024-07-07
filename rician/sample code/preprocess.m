function I2 = preprocess(imgFile1)

%% Wiener filter
I2 = wiener2(imgFile1, [3 3]);