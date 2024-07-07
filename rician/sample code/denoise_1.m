function b = denoise(image)

levels = input('What is the levels? ');
%%Doing the wavelet decomposition

ww = menu('Select a wavelet family','rbio1.5', 'db2', 'db3', 'sym3', 'coif2', 'bior1.1','haar');
switch ww
    case 1
        wname = ' rbio1.5' %'db1';
    case 2
        wname = 'db2';
    case 3
        wname = 'db3';
    case 4
        wname = 'sym3';
    case 5
        wname = 'coif2';
    case 6
        wname = 'bior1.1';
    case 7
        wname = 'haar';
end

[C,S] = wavedec2(image,levels,wname);
S
st = S(1,1)*S(1,2)+1;%length A +1
bayesC = [C(1:st-1),zeros(1,length(st:1:length(C)))];

%nhap ten Shrink_Theshold
disp('NameShrink:   1: Bayer;2 :VisuShrink (Universal);3: SureShrink; 4:Heuristic varian;') 
disp('5:Conventional Threshold or sqtwolog (fix form of Universal);6: MiniMaxi threshold')  
NameShrink = input('NameShrink:  ')
% NameShrink = input('NameShrink:1: Bayer;2 :VisuShrink;3: SureShrink')
    % 4:Heuristic varian; 5:Conventional Threshold or 'sqtwolog';6: MiniMaxi threshold'  
for jj = 2:size(S,1)-1
    %for the H detail coefficients
    coefh = C(st:st+S(jj,1)*S(jj,2)-1);
    %nguong H
    Thrh =ThresholdSelect(coefh,NameShrink);       % chuyen thang 2d matrix nhu dung detcoef2('h',C,S,muc tuy jj); 
    
    coefh_squ = reshape(coefh, [S(jj,1),S(jj,2)]);
    morph_cH = morph(coefh_squ);
    %'s':soft threshold, 'h':had threshold
    coefh_thr = wthresh(morph_cH,'s',Thrh);
    
    % chuyen thanh vecto tro lai de ghi vao C
    sthresh = reshape(coefh_thr,[1,S(jj,1)*S(jj,2)]);
    bayesC(st:st+S(jj,1)*S(jj,2)-1) = sthresh;
    st = st+S(jj,1)*S(jj,2);

    % for the V detail coefficients
    coefv = C(st:st+S(jj,1)*S(jj,2)-1);
     %Nguong V
    Thrv =ThresholdSelect(coefv,NameShrink) ;
   
    % chuyen thang 2d matrix nhu dung detcoef2('h',C,S,muc tuy jj);
    coefv_squ = reshape(coefv, [S(jj,1),S(jj,2)]);
    morpv_cV = morph(coefv_squ);
    coefv_thr = wthresh(morpv_cV,'s',Thrv);
    %coefv_thr = wthresh(morpv_cV,'h',Thrv);
    sthresv = reshape(coefv_thr,[1,S(jj,1)*S(jj,2)]); 
    bayesC(st:st+S(jj,1)*S(jj,2)-1) = sthresv;
    st = st+S(jj,1)*S(jj,2);
    
    %for D detail coefficients 
    coefd = C(st:st+S(jj,1)*S(jj,2)-1);
    % Nguong cua D; 'rigrsure' , 'heursure' , 'sqtwolog' , 'minimaxi'
    Thrd =ThresholdSelect(coefd,NameShrink);  
    % chuyen thang 2d matrix nhu dung detcoef2('h',C,S,muc tuy jj);
    coefd_squ = reshape(coefd, [S(jj,1),S(jj,2)]);
    morpd_cD = morph(coefd_squ);
    coefd_thr = wthresh(morpd_cD,'s',Thrd);
    %coefd_thr = wthresh(morpd_cD,'h',Thrd);
    sthresd = reshape(coefd_thr,[1,S(jj,1)*S(jj,2)]); 
    bayesC(st:st+S(jj,1)*S(jj,2)-1) = sthresd;
    st = st+S(jj,1)*S(jj,2); 
end

%Reconstructing the image
b = waverec2(bayesC,S,wname);