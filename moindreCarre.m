%La fonction cout au sens des moindres carrés
function resultat= moindreCarre (a,b,x,y_noisy)
    resultat=0;
    for i=1:length(x)
        resultat=resultat+(a*x(i)+b-y_noisy(i))^2;
        
    end
 end