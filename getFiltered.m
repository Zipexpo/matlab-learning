function filtered_signal=getFiltered(raw,filterType)
    filtered_signal =[];
    switch filterType
        case "wiener"
            filtered_signal = wiener2(raw);
        case "median"
            filtered_signal = medfilt1(raw);
        case "mean"
            windowSize = 5; 
            b = (1/windowSize)*ones(1,windowSize);
            a = 1;
            filtered_signal = filter(b,a,raw);
    end
end