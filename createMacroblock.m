function [finalrectfeatures rect_features11]= createMacroblock(i_height,i_width,n)
%createMacroblock creates macroblocks for processing of Sum of Absolute
%Diff
%   The function returns the locations of the macroblocks as a rectangele
%   which are used for further processing. The marcoblocks of the edges are
% only required. 
    % divide it in 10 parts 
%     n =10;
    d_width = floor(i_width/n);  % the shape of the marcoblock
    d_height  = floor(i_height/n);
    counter_temp =1;
    ww=1;
    hh=1;
    rect_features1(1,:)=[1 1 d_width d_height] ;
    % first row 
for i=1:(n-2)
    rect_features11(i,:)=[(d_width*i) (1*1) d_width d_height]; 
%     rect_features(i+10,:)=[(d_height*i) (d_width*1) d_height d_width];   
end 

 w2 = rect_features11(end,1)+ d_width;% width 2
 % the last pixels are left , we need to use that also hence adjust the
 % width 
 w3= rem(i_width,d_width)+d_width;
 
 rect_features2(1,:)=[(w2*1) (1) w3 d_height];
 
 % last column 
for i=1:(n-2)
    rect_features22(i,:)=[(w2*1) (d_height*i) w3 d_height] ;
% %     rect_features(i+10,:)=[(d_height*i) (d_width*1) d_height d_width];   
end 
% the third marcoblock in the left verticle side
 h2 = d_height;
 w4 = rect_features1(end,2);
 % first column 
for i=1:(n-2)
    rect_features3(i,:)=[(w4*1) (h2*i) d_width d_height] ;
% %     rect_features(i+10,:)=[(d_height*i) (d_width*1) d_height d_width];   
end 

  h3=rect_features22(end,2)+d_height;
  h4= rem(i_height,d_height)+d_height;
  
  rect_features4(1,:)=[1 h3 d_width h4] ;
%   Last row
  
for i=1:(n-2)
    rect_features44(i,:)=[(d_width*i) (h3*1) d_width h4]; 
% %     rect_features(i+10,:)=[(d_height*i) (d_width*1) d_height d_width];   
end

 rect_features5=[(d_width*(n-1)) (h3*1) w3 h4];
 rect_features=cat(1,rect_features1,rect_features11,rect_features2,rect_features22,rect_features3,rect_features4,rect_features44,rect_features5);
% % 
k=1;
for i=1:(n-2)
    for j=1:(n-2)
        newrect_features(k,:)=[(rect_features11(i,1)) rect_features22(j,2) d_width d_height];
        k=k+1;
        
    end
%     rect_features(i+10,:)=[(d_height*i) (d_width*1) d_height d_width];   
end
  finalrectfeatures=cat(1,rect_features,newrect_features);


end

