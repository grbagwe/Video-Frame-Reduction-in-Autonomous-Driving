clc;clear all;
close all;
% load('workspaceapr26_eucdist_testvideo3.mat')%second try 
% take the thresold and calculate the histogram of the number of times euc 
% distance is more than the thresold T ; This will be used to set the thresold G 
viObj =VideoReader('test4.MXF');
v_duration=  viObj.Duration;
v_framerate= viObj.FrameRate;
v_height = viObj.Height;
v_width  = viObj. Width;
v_numofframes = floor(v_duration * v_framerate)-1;
%format is [width height]


% tic 
rec =createMacroblock(v_height,v_width);
%%processing 
% v_numofframes=500;
% for i=200:10:1680
ntrframes=v_numofframes/3; % number of training frames 
%  
[ eucdismat1 thT i] = CreatethT(v_numofframes,viObj,rec);

             
  %% number of droped frames vs threshold 
  y = datasample(eucdismat1,round(ntrframes));
  Tth =mean(eucdismat1,1); 
  

  for ii=1:(v_numofframes-1)
%      img1=rgb2gray(read(viObj,ii));
%      img2=rgb2gray(read(viObj,ii+1));
%      eucdist=blockprocessing(img1,img2,rec);
       eucdist = eucdismat1(ii,:);
     SumEgth(ii)=sum(eucdist>thT); % sum of Euc dis greater than thresold th
     
  end 

  
  hh=histcounts(SumEgth,100);
  x=1:100;
  p = polyfit(1:100,hh,6);
  f = polyval(p,x);
plot(x,hh);
  hold on 

plot(x,f)
set(gca,'color','w');
set(gcf,'color','w');
  %   plot(hh)



