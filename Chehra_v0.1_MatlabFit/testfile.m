load('nnweights.mat');
testvid=csvread('extract.csv');
hiddenLayerSize = 120;
net = patternnet(hiddenLayerSize);
inputs=csvread('C:\Users\Abhinav Mishra\Desktop\projectdetail\project\MLP_NN\saveprise\input.csv');
targets=csvread('C:\Users\Abhinav Mishra\Desktop\projectdetail\project\MLP_NN\saveprise\target.csv');
net = configure(net,inputs',targets');
net = setwb(net,a);
y=net(testvid');
y=vec2ind(y);
count=zeros(5,1);
for i=1:size(y)
    count(y(i))=count(y(i))+1;
end
max=-999;
j;
for i=1:5
    if(count(i)>max)
        max=count(i);
        j=i;
    end
end
if(j==1)
    disp('anger')
elseif(j==2)
    disp('disgust')
elseif(j==3)
    disp('fear')
elseif(j==4)
    disp('happy')
else
    disp('sad')
end
delete 'extract.csv';