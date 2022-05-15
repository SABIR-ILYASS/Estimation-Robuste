function grad=gradient_cout(a,b,x,y_noisy)

    %cette fonction sert a calculer la dérivée de la fonction cout par rapport
         grad=[0;0];
         for i=1:length(x)
             r=a*x(i)+b-y_noisy(i);
             grad(1)=grad(1)+((x(i)*r)/(1+r^2));
             grad(2)=grad(2)+(r/(1+r^2));
         end
         grad=[grad(1);grad(2)];
         
    end
    
    