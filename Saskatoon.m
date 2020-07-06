Change dir to starting folder
%cd N:\AM_Collab\31-10879-Mohamed-BM-2020-02-06\Invar\AA40_2x_Dimax_F4_Al0.4\C3

% Process flats first
cd flats
files = dir('*.tif');

flats = zeros(2000, 2000, 10);

for i = 1:length(files)
    
    flats(:, :, i) = imread(files(i).name);

end

flatMean = mean(flats, 3);
flatSTD = std(flats, 0, 3);
flatSDoM = flatSTD/sqrt(10);

%% Part 2
% Process radios next
cd ../radios

files = dir('*.tif');

radios = zeros(2000, 2000, 10);

for i = 1:length(files)
    
    radios(:, :, i) = imread(files(i).name);

end

radioMean = mean(radios, 3);
radioSTD = std(radios, 0, 3);
radioSDoM = radioSTD/sqrt(10);

resultImage = radioMean - flatMean;
resultUncertainty = sqrt(radioSDoM^2 + flatSDoM^2);

% adjust the images to save them as unit16 tiff files
fmtResultImage = resultImage + 2^15;
fmtResultUncertainty = resultUncertainty + 2^15;

cd ..;
% save images as tiff files
imwrite(fmtResultImage, 'resultImage.tiff');
imwrite(fmtResultUncertainty, 'resultUncertaity.tiff');

% display the images with the same scale for comparison
%imshow(fmtResultImage,[]);
%minFmt = min(fmtResultImage,[],'all');
%maxFmt = max(fmtResultImage,[],'all');
%imshow(fmtResultUncertainty, [minFmt maxFmt]);
