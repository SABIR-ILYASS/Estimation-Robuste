function resultat = Plus_Forte_Pente(a,b, epsilon, beta1, beta2, lambda,sig,x,y_noisy, itr)


    i = 1;
    distance = 0;
    tic
    N = 100;
    alpha_i = 0.001;
    
    while (norm (gradient_cout(a,b,x,y_noisy)) > epsilon && i<=N)
        
        norme(i) = norm(gradient_cout(a,b,x,y_noisy));
        cout(i) = cou_Cauchy(a,b,sig,x,y_noisy);
        
        direction = - gradient_cout(a,b,x,y_noisy);
     
        alpha = Fletcher_Lemarechal(a,b,direction,alpha_i,beta1,beta2,lambda,sig,x,y_noisy);
        
        
        a=a+alpha * direction(1);
        b=b+alpha * direction(2);
        
        distance(i)=sqrt((alpha * direction(1))^2+(alpha*direction(2))^2);
        
        hold on;
        plot(a,b,'+', 'MarkerEdgeColor','r');  
        i = i + 1;
        
    end
    
    disp('Le vecteur optimal par la méthode de la plus forte pente');
    resultat = [a,b]
    
    disp('La valeur minimale de la fonction cout par la méthode de la plus forte pente');
    cout_Cauchy = cou_Cauchy(a,b,sig,x,y_noisy)
    
    hold off
    figure(itr + 1)
    subplot(2,2,1)
    plot(1:i-1,distance)
    title("1-Distance entre itérés");
    xlabel("Numéro d'itération") 
    ylabel('Distance entre itérés')
    
    subplot(2,2,2)
    plot(1:i-1,norme)
    title("2-Norme du gradient");
    xlabel("Numéro d'itération") 
    ylabel("Norme du gradient")
    
    subplot(2,2,[3,4])
    plot(1:i-1,cout)
    title("3-Evolution de la fonction de coût en fonction de l'itération");
    xlabel('Numéro d''itération') 
    ylabel('Evolution de la fonction de coût')
    
    
    end
             