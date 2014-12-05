%%September,2012. Coded by Shubham Agrawal as part of Semester Project, Subject: Soft Computing.
%% This is the final working program modified to go for option 3
% the below code is demonstrated for a 2-2-1 backpropagation network.

func=input('wat func u want to select')
if func==1
        f=inline('1./(1+exp(-1*alpha))');
        fdash=('(zout)*(1-zout)');
else if func==2
        f=inline('2./(1+exp(-1*alpha))-1');
        fdash=('.5*(1-zout*zout)');
  else if func==3
            f=inline('a');
            fdash=inline('1');
    end
end
end

   
%backpropagation

runorder=xlsread('E:\neuaraldata\attachments\input_data.xls','sheet1','f2:f93');
speed=xlsread('E:\neuaraldata\attachments\input_data.xls','sheet1','e2:e93');
feed=xlsread('E:\neuaraldata\attachments\input_data.xls','sheet1','d2:d93');
x=[ runorder speed feed ];
%x=[0.4 -0.7; 0.3 -0.5; 0.6 0.1; 0.2 0.4; 0.1 -0.2];
v=ones(3,3);
%v=[0.1 0.4; -0.2 0.2];
w=ones(3,1);
%w=[0.2;-0.5];
t=xlsread('E:\neuaraldata\attachments\output_data.xls','sheet1','b2:b93');
%t=[0.1; 0.05; 0.3; 0.25; 0.12];
eta=0.01;
alpha=0.8;
new_W=0;
new_V=0;
tolerance=0.0002;
j=5;
new_W=w;


iter =1;
for iter=1:1:90
l=1;
while l<92

    yin=v' * x(l,:)' ; %netj

yout=f(yin);    %f(netj)  OH
%%yout=yin;
%z=w' * yout;

zin=w' * yout;  %netk  IO

zout=f(zin);    %f(netk)    {O}o
%%zout=zin;

%%Error

j=((t(l)-zout)^2)/2; %Error for first desired output:t(1)..to compare it with tolerence

%omicron=(t(l)-zout)*(zout)*(1-zout);    %{d} (tk-Ook)Ook(1-Ook)
omicron=(t(l)-zout)*fdash(zout);

delta_W=eta*yout*omicron';% havent used momentum term alpha here.

new_W=w+delta_W;   %W(k+1)=alpha*Wk+deltaW
%w=new_W; % updating the weigths to be used in the next iteration.

        
        %%updating weights for input layer

        e=w*omicron;
 %       rho=e.*yout.*(1-yout); %w*omicron*f'(netj) 
            rho=e*fdash(yout);
% some problem with dimension produced in below matrix.. shud be 2X2.
%eta is a scalar, omicron in this case is a 1X1( since we have only one output, new_W, rho and x are 2X1 matrices 
delta_V=x(l,:)'*rho';%                     (eta*omicron)*new_W.*rho.*x  %no matrix multiplication between new_W and omicron,   wud have to increase eta...

 new_V=v+eta*delta_V;
v=new_V;
w=new_W;
l=l+1;
%subplot(2,1,1),plot(v,'+'),xlabel('v')
%subplot(2,1,2),plot(w,'o'),xlabel('w')
end
end

display(' the final weigths for input to hidden layer are:');
v
display(' the final weigths for hidden to output layer are:');
w
display('last calculated error is:');
j;

testrunorder=xlsread('E:\neuaraldata\attachments\input_data.xls','sheet1','f91:f101');
testspeed=xlsread('E:\neuaraldata\attachments\input_data.xls','sheet1','e91:e101');
testfeed=xlsread('E:\neuaraldata\attachments\input_data.xls','sheet1','d91:d101');
testdata = [testrunorder testspeed testfeed ]
realoutput=xlsread('E:\neuaraldata\attachments\output_data.xls','sheet1','b91:b101');
%testdata=[38 4500 8];
disp('target data:')
 realoutput
 %%
count=1;
ZFinal = [];
option=input(' do u want to compute outputs');
if option==1
 while count<12
    yinx=v' * testdata(count,:)' ; %netj
    
%youtx=f(yinx);    %f(netj)  OH
youtx=yinx;
%z=w' * yout;

zinx=w' * youtx;  %netk  IO

%zoutx=f(zinx)    %f(netk)    {O}o
zoutx=zinx;
ZFinal = [ ZFinal;zoutx];
count=count+1;
 end
 ZFinal
end
figure(1)
stem(ZFinal,'r'), 
hold on
stem ( realoutput,'g')
hold off