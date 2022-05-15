function gradient_a=derivee_a_cout(a,b,x,y_noisy)

    for j=1:length(a)
        for k=1:length(b)
            
         d_a=0;
    
         for i=1:length(x)
            d_a=d_a+((x(i)*(a(j)*x(i)+b(k)-y_noisy(i)))/(1+((a(j)*x(i)+b(k)-y_noisy(i))^2)));
         end
         gradient_a(j,k)=d_a;
        end
    end
end