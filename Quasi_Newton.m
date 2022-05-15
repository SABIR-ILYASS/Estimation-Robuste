% Méthode de Quasi-Newton
function ab_optimal=Quasi_Newton(a, b, beta1, beta2, lambda,epsilon,sig,x,y_noisy)
    
    %On initialise notre matrice H par la matrice identité  2x2
    H = eye(2);
    d_bar = 0;
    distance=0;
    N=100;
    alpha_i = 1;
    
    i = 1;
    while (norm(gradient_cout(a, b, x, y_noisy)) > epsilon && i<=N)
        
        % Pour  stocker la norme dans chaque itération
        norme(i) = norm(gradient_cout(a,b,x,y_noisy));
        
        % Pour stocker le cout dans chaque itération
        cout(i) = cou_Cauchy(a,b,sig,x,y_noisy);
        
        
        direction = - H * gradient_cout(a, b, x, y_noisy);  % la direction est une matrice (2,1)
    
        % On fait appel a la fonction Fletcher_Lemarechal
        alpha = Fletcher_Lemarechal(a, b, direction, alpha_i, beta1, beta2, lambda,sig, x, y_noisy);
    
        % Le nouveau vecteur
        a = a + alpha * direction(1);
        b = b + alpha * direction(2);
        
        % Mise a jour de H
        y =  gradient_cout(a, b, x, y_noisy) - gradient_cout(a- alpha * direction(1), b - alpha * direction(2), x, y_noisy) ; 
        d_bar = alpha .* direction; 
        
        % Calcul de H
      
         
        Q=eye(2)-((d_bar * y')./(d_bar' *y));
        M=eye(2)-(((y* d_bar')./(d_bar' * y)));
        P=(d_bar * d_bar')./(d_bar' * y);
        H=Q*H*M+P;
        
        % Pour stocker la distance dans chaque itération
        distance(i)=sqrt((alpha * direction(1))^2+(alpha*direction(2))^2);
        
        % On trace le cheminement du point courant au cours des itérations
        
        hold on;
        axis equal;
        plot(a,b,'+', 'MarkerEdgeColor','r');
        
        % On incremente le compteur d'iterations
        i = i + 1;
        
    end
    
    
    disp('Le vecteur optimal par la méthode de Quasi Newton');
    ab_optimal=[a,b]
    
    disp('La valeur minimale de la fonction cout  par la méthode de Quasi Newton');
    cout_Cauchy=cou_Cauchy(a,b,sig,x,y_noisy)
    
    hold off
    figure(30)
    subplot(2,2,1)
    length(distance)
    plot(1:i-1,distance)
    title("1-Distance entre itérés en fonction de l''itération");
    xlabel('Numéro d''itération') 
    ylabel('Distance entre itérés')
    
    subplot(2,2,2)
    plot(1:i-1,norme)
    title("2-Norme du gradient en fonction de l''itération");
    xlabel('Numéro d''itération') 
    ylabel('Norme du gradient')
    
    subplot(2,2,[3,4])
    plot(1:i-1,cout)
    title("3-Evolution de la fonction de cout en fonction de l''itération");
    xlabel('Numéro d''itération') 
    ylabel('Evolution de la fonction de cout')
    
    
        
    end