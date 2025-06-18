function images2bmp(inputFolder)
    % 1. Validate input folder
    if ~isfolder(inputFolder)
        error('The specified folder does not exist.');
    end

    % 2. Create output folder with '_bmp' suffix
    [folderPath, folderName] = fileparts(inputFolder);
    outputFolder = fullfile(folderPath, [folderName, '_bmp']);
    if ~exist(outputFolder, 'dir')
        mkdir(outputFolder);
    end

    % 3. Define supported image formats
    imgExts = {'*.jpg', '*.jpeg', '*.png', '*.tif', '*.tiff', '*.ppm'}; 
    imageFiles = [];
    for k = 1:length(imgExts)
        imageFiles = [imageFiles; dir(fullfile(inputFolder, imgExts{k}))];
    end

    % 4. Loop through each image and save as BMP
    for k = 1:length(imageFiles)
        filename = imageFiles(k).name;
        fullpath = fullfile(inputFolder, filename);
        img = imread(fullpath);

        [~, name, ~] = fileparts(filename);
        newFilename = fullfile(outputFolder, [name, '.bmp']);
        imwrite(img, newFilename);
    end

    fprintf('Converted %d images to BMP format in:\n%s\n', length(imageFiles), outputFolder);
end