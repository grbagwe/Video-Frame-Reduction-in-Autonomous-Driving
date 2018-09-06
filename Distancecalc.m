function [ecdist] = Distancecalc(rectmat, img1, img2)
%[ ssdist sadist ecdist normecdist] 
% [ eucl_dist sumabsdif diffgreatmean] = sumofAbsdiff(rectmat, img1, img2)
%   Calculates [SSD SAD Eucdistance]

%Sum of Abs Diff calculates the amount of similarity 
sumabsdif=1;
diffgreatmean=1;
%   the rectmat is the matrix containing information of location of the
%   marcoblocks 
marco_rows = size(rectmat,1);
sumabdif=zeros(marco_rows);
for i=1:marco_rows
    im1= imcrop(img1,rectmat(i,:));
    im2= imcrop(img2,rectmat(i,:));
    imd= im2-im1 ; % diff between the frames 
    ssdist(i)= sum(sum((imd) .^2));  % SSD
%     sadist(i) = sum(sum(abs(imd))); % SAD 
    ecdist(i) =sqrt(ssdist(i)); %Eucludican Distance 
%     normecdist(i) = sqrt(ssdist(i)) /size(im1,1)/size(im1,2); 
end 


% figure,
%     subplot(2,2,1), imshow(img1);
%    title('img1 in gray ')
%    subplot(2,2,2),imshow(img2);
%    title('img2')
%    subplot(2,2,3),imshow(im1);
%    title('im1')
% subplot(2,2,3),imshow(im2);
%    title('im2')
%     meansad = sqrt (var(sumabsdif));
%     diffgreatmean = sumabsdif>(meansad);
%   soadfi=sqrt( sum(sum((img2-img1) .^2)) );% sum of abs diff full image
end


