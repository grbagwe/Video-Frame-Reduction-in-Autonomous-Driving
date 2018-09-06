function [eucd] = blockprocessing(img1,img2,rec)

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% [v_height v_width ]=size(img1); 
% rec= createMacroblock(v_height,v_width); 
[eucd]=Distancecalc(rec,img1,img2);


end

