B=[0,0; 77,68; 12,75; 32,17; 51,64; 20,19; 72,87; 80,37; 35,82;
2,15; 18,90; 33,50; 85,52; 97,27; 37,67; 20,82; 49,0; 62,14; 7,60;
100,100];
pocet_genov=size(B,2)-2;

n = size(B, 1);	
firstpop =B;
for i=1:10
R = randperm(n);
Shuffled_B= B(R, :);
firstpop = [firstpop,Shuffled_B];
end
xd=generate_my_pop(20,20);
firstpop
xd
function pop=generate_my_pop(num_of_genes,num_of_pop)
    pop=zeros(num_of_pop,num_of_genes);
    
    [~,pop(:)]=sort(rand(num_of_pop,num_of_genes),2);
    
    pop(:)=pop+1;
end