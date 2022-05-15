function alpha=Fletcher_Lemarechal(a,b,direction,alpha_i,beta1,beta2,lambda,sig,x,y_noisy)


    alpha_r = 50000; 
    alpha_l = 0;
    
    
    alpha = alpha_i;
    
    
        %On calcule la variable gamma 
        gamma=-beta1*gradient_cout(a,b,x,y_noisy)'*direction;
    
        %On calcule la premi�re condition de wolfe
        cw1=cou_Cauchy(a+alpha*direction(1),b+alpha*direction(2),sig,x,y_noisy)-cou_Cauchy(a,b,sig,x,y_noisy)+ alpha*gamma; 
        vect=gradient_cout(a+alpha*direction(1),b+alpha*direction(2),x,y_noisy);
    
        %On calcule la deuxi�me condition de wolfe
        cw2=(vect'*direction)/(-direction'*direction);
        
    %On fait le test sur les conditions cw1 et cw2
    
    if ((cw1<0)&& (cw2<beta2))
        
        alpha=alpha;
    else
        if (cw1>0)  
          %cw1 est viol�e donc pas  trop long
          alpha_r=alpha;
          alpha=(alpha_l+alpha_r)/2;
          
        else
            
          %cw2 est viol�e donc pas trop court
           alpha_l=alpha;
          
          if (alpha_r < 50000)
                    
                    alpha = (alpha_l + alpha_r) / 2;
                    
          else
              
                    alpha = lambda * alpha;
          end
        end
    end
    end
    
    
        
        
         