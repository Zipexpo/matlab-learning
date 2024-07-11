function entropy = KLD(p,q)
    entropy = 0;
    n = min(length(p),length(q));
    P = normalize(reshape(p,[n,1]),"norm",1);           
    Q = normalize(reshape(q,[n,1]),"norm",1); 
    % tf = P~=0 & Q~=0;
    tf = Q~=0;
    entropy = nansum(P(tf).*log( P(tf)./Q(tf) ));
end