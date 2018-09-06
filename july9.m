clc
clear all;
close all;

ViObj = VideoReader('C:\Users\grbag\OneDrive\Documents\Video Data Reduction project\programs\test6.mp4');
nblock = 10 ;
rec =createMacroblock(ViObj.Height,ViObj.Width,nblock);
img = read(ViObj,10);
imshow(img);
hold on;
for i=1:100 
    rectangle('Position',rec(i,:),'Edgecolor','g','LineWidth',0.75);
    
    
end
hold off; 
title('\fontsize{10} Creation of Blocks N x N');

%%
%%without block processing 
% tic 
% fwoblkcrt  =@() woblockcreation(ViObj);
% t1 = timeit(fwoblkcrt);
% toc0 = toc;
% 
% 
% tic 
%  t5 =@() vdrtraining(ViObj,5);
% tpc5 = toc;
% 
%  tic 
%  wbk10=@() vdrtraining(ViObj,10);
%   t10  = timeit(wbk10) ;
%  toc10=  toc ;
%   
%  tic 
%  wbk15=@() vdrtraining(ViObj,15);
%   t15  = timeit(wbk15) ;
%   toc15=  toc ;
%  tic 
%  wbk20=@() vdrtraining(ViObj,20);
%   t20  = timeit(wbk20) ;
%   toc20=  toc ;
%   
%   
%  tic 
%  wbk25=@() vdrtraining(ViObj,25);
%   t25  = timeit(wbk25) ;
%   toc25=  toc ;
%  
%  tic 
%  wbk30=@() vdrtraining(ViObj,30);
%   t30  = timeit(wbk30) ;
%   toc30=  toc ;
 %%%%%%%%%%%%%%%%%%%%%%%%%%
tic 
   [euc00,meanttoc00]= woblockcreation(ViObj);
trtime00 =toc 

tic 
 [eucd5,mtoc5] = vdrtraining(ViObj,5);
 trtime5 =toc
 
tic 
[eucd10,mtoc10] = vdrtraining(ViObj,10);
trtime10 = toc

tic 
[eucd15,mtoc15] = vdrtraining(ViObj,15);
trtime15 = toc


  tic 
 [eucd20,mtoc20] = vdrtraining(ViObj,20);
 
trtime20 =toc
tic 
 [eucd25,mtoc25] = vdrtraining(ViObj,25);
 trtime25 =toc  
tic 
 [eucd40 mtoc30] = vdrtraining(ViObj,30);
 t30 =toc
 
 %% 
  th00 = mean(euc00,1);
  th5  = mean(eucd5,1);
  th10 = mean(eucd10,1);
  th20 = mean(eucd20,1);
  th25 = mean(eucd25,1);
  th30 = mean(eucd40,1);
  
  
   ThG00= round(mean(sum((euc00>th00),2)));
   ThG5= round(mean(sum((eucd5>th5),2)));
   ThG10= round(mean(sum((eucd10>th10),2)));
   ThG20= round(mean(sum((eucd20>th20),2)));
   ThG25= round(mean(sum((eucd25>th25),2)));
   ThG30= round(mean(sum((eucd40>th30),2)));

 %%
  testvideo = VideoReader('test68.mp4');
  v_numberofframes = floor(testvideo.FrameRate*testvideo.Duration);
  
  rec5 = createMacroblock(testvideo.Height,testvideo.Width,5);
  rec10 = createMacroblock(testvideo.Height,testvideo.Width,10);
  rec20 = createMacroblock(testvideo.Height,testvideo.Width,20);
  rec25 = createMacroblock(testvideo.Height,testvideo.Width,25);
  rec30 = createMacroblock(testvideo.Height,testvideo.Width,30);
  
  
  count00=0;
  count5=0;
  count10=0;
  count20=0;
  count30=0;
  count25=0;
  
  for i =2: v_numberofframes
   
     img1 = read(ViObj,i);
     img2 = read(ViObj,i-1);
     img1g =rgb2gray(img1);
     img2g = rgb2gray(img2);
     teuc0(i,:)= reshape(abs(img1g-img2g),1,[]);
     [ssd12(i,:),sad12(i,:),teucd5(i,:),neucd12(i,:)]= blockprocessing(img1g,img2g,rec5);
     
     [tssd12(i,:),tsad12(i,:),teucd10(i,:),tneucd12(i,:)]= blockprocessing(img1g,img2g,rec10);
     
     [tssd20(i,:),tsad20(i,:),teucd20(i,:),tneucd20(i,:)]= blockprocessing(img1g,img2g,rec20);
     
     [tssd25(i,:),tsad25(i,:),teucd25(i,:),tneucd25(i,:)]= blockprocessing(img1g,img2g,rec25);
     
     [tssd30(i,:),tsad30(i,:),teucd30(i,:),tneucd30(i,:)]= blockprocessing(img1g,img2g,rec30);
     
     if sum(teuc0(i,:)>th00)>ThG00
         count00 = count00+1;
     end
     if sum(teucd5(i,:)>th5)>ThG5
         count5 = count5+1;
     end
     if sum(teucd10(i,:)>th10)>ThG10
         count10 = count10+1;
     end
     if sum(teucd20(i,:)>th20)>ThG20
         count20 = count20+1;
     end
     if sum(teucd25(i,:)>th25)>ThG25
         count25 = count25+1;
     end
     if sum(teucd30(i,:)>th30)>ThG30
         count30 = count30+1;
     end
   
  
  
  end
      count00/v_numberofframes
      count5/v_numberofframes
      count10/v_numberofframes
      count20/v_numberofframes
      count25/v_numberofframes
      count30/v_numberofframes