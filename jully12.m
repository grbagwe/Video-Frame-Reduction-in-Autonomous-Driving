clc;
clear all;
close all;

ViObj = VideoReader('test9.mp4');

v_numberofframes = floor(ViObj.FrameRate*ViObj.Duration);
%% Create Blocks 
nblock=10; % n x n blocks

rec =createMacroblock(ViObj.Height,ViObj.Width,nblock);


%% Display the blocks
% img1=read(ViObj,1);
% figure,imagesc(img1)
% 
% set(gcf,'color','w');
% title('Create Blocks 10 x 10 ');
% for i=1:1:(nblock*nblock)
% hold on;
% rectangle('Position',rec(i,:),...
%          'EdgeColor','g',...
%          'LineWidth',2,'LineStyle','--')
% end

%% Temporal processing 
trimg = datasample(1:v_numberofframes,round(v_numberofframes/10));

%% Training 
disp('training started')
 for i=1:length(trimg)
   frmnum  = trimg(i);
   if frmnum~=1
     img1 = read(ViObj,frmnum);
     img2 = read(ViObj,frmnum-1);
     img1g =rgb2gray(img1);
     img2g = rgb2gray(img2);
     [eucd12(i,:)]= blockprocessing(img1g,img2g,rec);
   end
%    if i == round(length(trimg)/10)
%        disp('10 percent done')
%    elseif i == round(length(trimg)*30/100) 
%        disp('30 percent done');
%    elseif i == round(length(trimg)*50/100)
%        disp('50 percent done');
%    elseif i == round(length(trimg)*70/100)
%        disp('70 percent done');
%    elseif i == round(length(trimg)*90/100)
%        disp('90 percent done');
%    
%    end
 end
 disp('training ended')
 %% 
  meaneucd = mean(eucd12,1);
 trimg2 = datasample(1:v_numberofframes,round(v_numberofframes/20));
  for i=1:length(trimg2)
   frmnum  = trimg2(i);
   if frmnum~=1
     img1 = read(ViObj,frmnum);
     img2 = read(ViObj,frmnum-1);
     img1g =rgb2gray(img1);
     img2g = rgb2gray(img2);
     [neweucd12]= blockprocessing(img1g,img2g,rec);
    if neweucd>=meaneucd
        newThg(i,:) = sum(neweucd); 
    end
   end
%    if i == round(length(trimg)/10)
%        disp('10 percent done')
%    elseif i == round(length(trimg)*30/100) 
%        disp('30 percent done');
%    elseif i == round(length(trimg)*50/100)
%        disp('50 percent done');
%    elseif i == round(length(trimg)*70/100)
%        disp('70 percent done');
%    elseif i == round(length(trimg)*90/100)
%        disp('90 percent done');
%    
%    end
 end
 
%  meanssd = mean(ssd12,1);
%  meansad = mean(sad12,1);
%  meaneucd = mean(eucd12,1);
%  meanneucd = mean(neucd12,1);
 ThG= round(mean(sum((eucd12>meaneucd),2)));
 
 % training 
  
 
 
 %%
 img1=read(ViObj,1);
 img1g= rgb2gray(img1);
 thisfile = sprintf('out%04s_%s.avi',vname,date);
 
 v = VideoWriter(thisfile);
 open(v) 
 writeVideo(v,img1);
 count=0;
 disp('testing started')
 for i=2 :v_numberofframes
 img2=read(ViObj,i);
 img2g= rgb2gray(img2);
  [a b neweucd c]= blockprocessing(img1g,img2g,rec);
  detecttp = neweucd>meaneucd;
  if sum(detecttp)>ThG
      img1g=img2g;
      writeVideo(v,img2);
  else 
      img1g=img1g;
      count=count+1;
      skpframes(count)=i;
  end
      
 end
 close(v);
%  implay(v);
ans = count*100/v_numberofframes 
disp('end')
