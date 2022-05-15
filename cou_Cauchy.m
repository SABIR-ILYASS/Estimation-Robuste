%La fonction de cout de pénalisation de Cauchy
function cm=cou_Cauchy(a,b,sig,x,y_noisy)
    cm=0;
    n=length(x);
    for i=1:n
        cm=cm+penalisation(a*x(i)+b-y_noisy(i),sig);
    end