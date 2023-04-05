% Read Image
StackNinja = imread("StackNinja1.bmp");

% Brighten Image
brightenStackNinja = imlocalbrighten(StackNinja);

% Extracting green colour elements using Green - ((Red + Blue) / 2)
redStack = brightenStackNinja(:,:,1);
greenStack = brightenStackNinja(:,:,2);
blueStack = brightenStackNinja(:,:,3);

greenness = greenStack - ((redStack + blueStack) / 2);

% Median filtering to remove noise
medStack = medfilt2(greenness, [1 1]);

% Binarize the image
binaryMedStack = imbinarize(medStack, "adaptive");

% Opening image
se = strel('disk', 2);
openStack = imopen(binaryMedStack, se);

% Label2RGB - Inserting colour
bwStack = bwconncomp(openStack);
matrixStack = labelmatrix(bwStack);
numberComponents = bwStack.NumObjects;
randColour = rand(numberComponents, 3);
rgbStack = label2rgb(matrixStack, randColour, 'black');

figure();
imshowpair(StackNinja, rgbStack, 'montage');
title('Before vs. After');

