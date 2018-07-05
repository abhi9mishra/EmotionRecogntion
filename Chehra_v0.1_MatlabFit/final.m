clear; close all;
addpath(genpath('.'));

% % Load Models
fitting_model='models/Chehra_f1.0.mat';
load(fitting_model);    

% % Test Path
image_path='test_images/';
img_list=dir([image_path,'*.jpg']);

% % Perform Fitting
%video_path='C:/Users/Lakshay/Documents/aiedx/sadness/';
%video_list=dir([video_path,'*.avi']);

%for k=1:216
%    disp(k)
    obj=VideoReader('C:\Users\Abhinav Mishra\Desktop\projectdetail\project\disgust_milind.mp4');
    video=obj.read();
    a=size(video);
    %imshow(video(:,:,:,1));
    csvmat = zeros(a(4),98);
    flag=0;
    for i=1:a(4)
        % % Load Image
        img=video(:,:,:,i);
        img = imresize(img,1/2);
        test_image=im2double(img);
        %imshow(test_image);hold on;

        faceDetector = vision.CascadeObjectDetector();
        bbox = step(faceDetector, test_image);
        if(numel(bbox)==0)
            flag=1;
            break;
        end;
        test_init_shape = InitShape(bbox,refShape);
        test_init_shape = reshape(test_init_shape,49,2);
       % plot(test_init_shape(:,1),test_init_shape(:,2),'ro');

        if size(test_image,3) == 3
            test_input_image = im2double(rgb2gray(test_image));
        else
            test_input_image = im2double((test_image));
        end

        % % Maximum Number of Iterations 
        % % 3 < MaxIter < 7
        MaxIter=4;
        test_points = Fitting(test_input_image,test_init_shape,RegMat,MaxIter);
        %plot(test_points(:,1),test_points(:,2),'g*','MarkerSize',6);hold off;
        for j = 1:49
            csvmat(i,2*j-1)  = test_points(j,1);
            csvmat(i, 2*j) = test_points(j,2);
        end

        %legend('Initialization','Final Fitting');
        %set(gcf,'units','normalized','outerposition',[0 0 1 1]);
        %%pause(0.1);
       
    end
    if(flag==1)
        continue;
    end;
     dlmwrite('extract.csv' , csvmat,'-append');
%end
   clear;
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