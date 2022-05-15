% On charge les données du x et y_noisy du fichier data.mat
filename = 'data.mat';
load(filename,'x');
load(filename,'y_noisy');

% Partie 1 :  Estimation au sens des moindres carrés 
              
%**************************************************************************************************%

% Question 1 :

% On initialise les vecteurs a et b par une plage des valeurs choisies d'après 
% une analyse de la figure en page 1.

a = -20:0.1:60;
b = -20:0.1:60;
n = length(a);
m = length(b);


% On initialise notre matrice qui va contenir les valeurs de la fonction
% coût au sens des moindres carrés en fonction de a et b.
valeurs = zeros(n,m);


for i = 1:n
    for j = 1:m
        % On fait appel à notre fonction coût au sens des moindres carrés.
        valeurs(i,j) = moindreCarre(a(i), b(j), x, y_noisy);
    end
end

% On crée notre grille 2D avec meshgrid.
[A,B] = meshgrid(a,b);

% On trace la représentation de la fonction coût avec mesh et contour.
figure(1)
mesh(A, B, valeurs)
title("Représentation de la fonction coût au sens des moindres carrés");
colorbar
figure(2)
contour(A, B, valeurs)
title("Représentation de la fonction coût au sens des moindres carrés");
colorbar

%**************************************************************************************************%

% Question 2 :

% On cherche une solution approchée au problème.

% On affecte à notre minimun la valeur de coût qui correspond à la première
% valeur de a et b de l'intervalle choisi.

min=moindreCarre(a(1),b(1),x,y_noisy);
 
% Dans ia_optimal et ib_optimal on va stocker les indices des valeurs qui
% correspondent à a_optimal et b_optimal.
ia_optimal=0;ib_optimal=0;

% On parcourt la matrice valeurs qui contient les différents valeurs de la
% fonction coût et on cherche le minimum.
for i=1:n
    for j=1:n
        if (min>valeurs(i,j))
           % On garde la valeur minimale pour l'itération courante, et on
           % continue à chercher une valeur plus petite que celle de min.
           min=valeurs(i,j);
      
           % On garde les indices correspondants aux valeurs optimales.
           ia_optimal=i;
           ib_optimal=j;  
        end
    end
end
disp('-------------------------Question 2------------------------');
disp('Le vecteur de la solution approchée par la méthode des moindres carrés :')
vect_optimal=[a(ia_optimal),b(ib_optimal)]
disp('La valeur minimale de la fonction coût par la méthode des moindres carrés :')
min
disp('-------------------------Fin Question 2------------------------');
 
%**************************************************************************************************%

% Question 3 :

a_optimal =  0;
b_optimal =  0;
moy_x = 0;
moy_y = 0;

moy_x = sum(x) / 30;
moy_y = sum(y_noisy) / 30;

total = 0;
total1 = 0;

for i=1:30
    total = total + (x(i) - moy_x)*(y_noisy(i) - moy_y);
    total1 = total1 + (x(i) - moy_x)^2;
end


disp('-------------------------Question 3------------------------');
disp('Les valeurs de a et b par la formule de minimisation quadratique :');
a_optimal =  total / total1
b_optimal = moy_y - a_optimal * moy_x
disp('-------------------------Fin Question 3------------------------');

%**************************************************************************************************%

% Question 4 :

% On garde la même figure de la première question pour qu'on puisse
% vérifier si le couple trouvé dans la question précedente est évidemment le min
figure(1)
hold on
plot3(a_optimal, b_optimal,moindreCarre(a_optimal,b_optimal,x,y_noisy),'.r','markersize',30)
hold off

%**************************************************************************************************%

% Question 5 :
 
% On trace la courbe y = a_optimal *x + b_optimal
figure(2)

% On trace le nuage des points
scatter(x,y_noisy)
hold on

% On trace la droite
plot(x,a_optimal*x+b_optimal)
title("La courbe d'équation y = 6.9485 * x + -2.3803");
xlabel('x');
ylabel('y');
hold off

%**************************************************************************************************%

% Partie 2 : Estimation robuste
              
%**************************************************************************************************%
        
% On initialise d'abord les constantes qu'on aura sûrement besoin des les
% questions suivantes.

sig=1;   
epsilon = 0.0001;
beta1 = 0.01;
beta2 = 0.99;
lambda = 30;
itr_figure = 20;

%**************************************************************************************************%

% Question 6 :

% Dans la fonction Plus_Forte_Pente, en faite on la change juste dans cette
% question pour pouvoir l'appliquer à la fonction coût au sens desmoindres
% carrés, on trace la courbe et on obtient les résultats et puis on remet
% la fonction dans son état original, que vous trouverez maintenant.

disp('-------------------------Question 6------------------------');
figure(3);
R=moindreCarre(A,B,x,y_noisy);
hold off;
title('Méthode de la plus forte pente pour la fonction coût des moindres carrés');
hold on;
contour(A,B,R);
Plus_Forte_Pente(0, 0, epsilon, beta1, beta2, lambda,sig,x,y_noisy, itr_figure);
itr_figure = itr_figure + 1;
hold off;
disp('-------------------------Fin Question 6------------------------');

%**************************************************************************************************%

% Question 7 :

R=-20:0.1:60;

% On fait appel à notre fonction de pénalisation
figure(4)
plot(R,penalisation(R,1));
title("Représentation de la fonction pénalisation pour sigma=1")
xlabel('r = -20:0.1:60');
ylabel('penalisation(r,1)');

%**************************************************************************************************%

% Question 8 :
 
% On initialise notre matrice qui va contenir les valeurs de la fonction
% coût de Cauchy en fonction de a et b

valeurs=zeros(n,m);

for i=1:n
    for j=1:n
        
        %On fait appel à la fonction cout_Cauchy
        valeurs(i,j)=cou_Cauchy(a(i),b(j),sig,x,y_noisy);
    end
end

% On représente la fonction coût de Cauchy dans l'espace des paramétres a et b
figure(5)
contour(A,B,valeurs);
title("Représentation de la fonction de coût robuste");
colorbar

%**************************************************************************************************%

% Question 9 :

% On représente le gradient comme un champ de vecteurs avec la fonction Matlab
% quiver ainsi que les lignes de niveaux de la fonction coût (utilisation
% de axis equal)

figure(6)
axis equal

% On trace les lignes des niveaux de la fonction coût
contour(A,B,valeurs)
hold on
axis equal

% On fait appel à la fonction derivee_a_cout et derivee_b_cout 
% derivee_a_cout(a,b,x,y_noisy) nous retourne la matrice qui contient les valeurs du dérivée 
% du coût par rapport à 'a' en itérant sur les valeurs de a et b.
% derivee_b_cout(a,b,x,y_noisy) nous retourne la matrice qui contient les valeurs du dérivée 
% du coût par rapport à 'b' en itérant sur les valeurs de a et b.
% On trace le gradient de la fonction coût avec la fonction quiver

quiver(a,b,derivee_a_cout(a,b,x,y_noisy),derivee_b_cout(a,b,x,y_noisy));
title("Représentation du gradient de la fonction coût de Cauchy et ses lignes de niveaux");
hold off

%**************************************************************************************************%

% Question 10 :


disp('-------------------------Question 10------------------------');
a = 0;
b = 0;
figure(7);
R=cou_Cauchy(A,B,sig,x,y_noisy);
hold off;
title('Methode de la plus forte pente');
hold on;
contour(A,B,R);
Plus_Forte_Pente(a,b,epsilon, beta1, beta2, lambda,sig,x,y_noisy, itr_figure);
itr_figure = itr_figure + 1;
hold off; 
disp('-------------------------Fin Question 10------------------------');

%**************************************************************************************************%

% Question 11

% On répéte l'étude faite dans la question précedente pour d'autres points de depart
disp('-------------------------Question 11------------------------');

a=0:2:8;
b=-4:2:4;
for itr=1:4
    X = sprintf('Pour l''itération %d :',itr);
    disp(X)
    figure(7+itr);
    R=cou_Cauchy(A,B,sig,x,y_noisy);
    hold off;
        title('Methode de la plus forte pente');
    hold on;
    contour(A,B,R);
    Plus_Forte_Pente(a(itr),b(itr),epsilon, beta1, beta2, lambda,sig,x,y_noisy, itr_figure);
    itr_figure = itr_figure + 1;
    hold off;
 
end 

disp('-------------------------Fin Question 11------------------------');

%**************************************************************************************************%

% Question 12

disp('-------------------------Question 12------------------------');
a=0;
b=-2;
figure(14);
R=cou_Cauchy(A,B,sig,x,y_noisy);
hold off;
title('Methode quasi-Newton BFGS');
hold on;
contour(A,B,R);
Quasi_Newton(a,b,beta1,beta2,lambda,epsilon,sig,x,y_noisy);

hold off;
disp('-------------------------Fin Question 12------------------------');

%**************************************************************************************************%

% Question 13

disp('-------------------------Question 13------------------------');
a_optimal_mc=12.0713;
b_optimal_mc=0.9640;

a_optimal_cau=2.5848 ;
b_optimal_cau=1.6338;

%On trace la courbe   y = a_optimal *x + b_optimal
figure(15)
scatter(x,y_noisy)
hold on
p=plot(x,a_optimal_mc*x+b_optimal_mc,"",x,a_optimal_cau*x+b_optimal_cau,"g");
legend('nuage des points','droite avec les moindres carrés','droite avec la pénalisation robuste de Cauchy');
title('Représentation des droites ajustées au nuage depoint')
p(1).LineWidth = 1
p(2).LineWidth = 1;
hold off
disp('-------------------------Fin Question 13------------------------');

