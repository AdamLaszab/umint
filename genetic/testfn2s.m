% Test function 2s (Rastigin's objective function with shifted optimum)
% It is a multimodal function with optional number of input variables.
% The global optimum is in S;  Fit(X)=10;
% Other local minimas are located in a grid with the step=1
% Search space: -5 < x(i) < 5

function[Fit]=testfn2s(Pop)

[lpop,lstring]=size(Pop);
S=(1:lstring)*0.1;  % posun globalneho extremu z nuly

for i=1:lpop
  X=Pop(i,:);
  Fit(i)=lstring*10+10;	
  for j=1:lstring
    Fit(i)=Fit(i)+((X(j)-S(j))^2-10*cos(2*pi*(X(j)-S(j))));
  end     
end
