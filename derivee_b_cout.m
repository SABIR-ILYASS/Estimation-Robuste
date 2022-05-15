function gradient_b=derivee_b_cout(a,b,x,y_noisy)

    for j=1:length(a)
        for k=1:length(b)
            
         d_b=0;

         for i=1:length(x)
            d_b=d_b+(((a(j)*x(i)+b(k)-y_noisy(i)))/(1+((a(j)*x(i)+b(k)-y_noisy(i))^2)));
         end
         gradient_b(j,k)=d_b;
        end
    end
end
    