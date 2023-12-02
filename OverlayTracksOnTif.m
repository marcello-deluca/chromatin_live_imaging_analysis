function [] = OverlayTracksOnTif(tracks,path,file,OutFile)
    figure();
    inputTif = sprintf("%s/%s.tif",path,file);
    info = imfinfo(inputTif);
    numberOfPages = length(info);
    gain = 1;
    thisPage = imread(inputTif,1).* gain;
    imshow(thisPage);
    title(sprintf("%s", file),'Interpreter', 'none');
    set(gcf,'Position',[0 0 500 500]);
    hold on
    curr = tracks;
    for i=1:length(curr)
        plot(curr{i}(1,:),curr{i}(2,:));
    end
    exportgraphics(gcf,OutFile);
end