clear
% suradnice x,y,z piatich skupin bodov
load databody

% vykreslenie bodov podla skupin
h=figure;
plot3(data1(:,1),data1(:,2),data1(:,3),'b+')
hold on
plot3(data2(:,1),data2(:,2),data2(:,3),'co')
plot3(data3(:,1),data3(:,2),data3(:,3),'g*')
plot3(data4(:,1),data4(:,2),data4(:,3),'r*')
plot3(data5(:,1),data5(:,2),data5(:,3),'mx')

axis([0 1 0 1 0 1])
title('Data body')
xlabel('x')
ylabel('y')
zlabel('z')



% vstupne a vystupne data na trenovanie neuronovej siete
 datainnet=[data1;data2;data3;data4;data5]
 datainnet=transpose(datainnet)
 dataoutnet=[ones(1, 50), zeros(1, 50), zeros(1, 50), zeros(1, 50), zeros(1, 50);
     zeros(1, 50), ones(1, 50), zeros(1, 50), zeros(1, 50), zeros(1, 50);
     zeros(1, 50), zeros(1, 50), ones(1, 50), zeros(1, 50), zeros(1, 50);
     zeros(1, 50), zeros(1, 50), zeros(1, 50), ones(1, 50), zeros(1, 50);
     zeros(1, 50), zeros(1, 50), zeros(1, 50), zeros(1, 50), ones(1, 50)];

% vytvorenie struktury siete
 pocet_neuronov=[16];
 net = patternnet(pocet_neuronov);

% parametre rozdelenia dat na trenovanie, validacne a testovanie
 net.divideFcn='dividerand';
 net.divideParam.trainRatio=0.8;
 net.divideParam.valRatio=0;
 net.divideParam.testRatio=0.2;

 %nastavenie parametrov trenovania 
net.trainParam.goal = 1e-7;       
net.trainParam.min_grad = 1e-5;   
net.trainParam.show = 20;         
net.trainParam.epochs = 220;      
net.trainParam.max_fail = 10;     
% trenovanie NS
 net = train(net,datainnet,dataoutnet);

% zobrazenie struktury siete
 view(net)

% simulacia vystupu NS pre trenovacie data
% testovanie NS
 outnetsim = sim(net,datainnet);

% chyba NS a dat
 err=(outnetsim-dataoutnet);

% percento neuspesne klasifikovanych bodov
 c = confusion(dataoutnet,outnetsim)

% kontingenèná matica
 figure
 plotconfusion(dataoutnet,outnetsim)

% test
X=[0.8 0.7 0.5 0.7 0.6;0.4 0.8 0.5 0.1 0.3; 0.5 0.3 0.8 0.2 0.5];

y = net(X);
disp(y);