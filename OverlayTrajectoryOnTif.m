function [] = OverlayTrajectoryOnTif(Traj,path,file,OutFile)
    figure();
    inputTif = sprintf("%s/%s.tif",path,file);
    inputTraj = Traj;
    info = imfinfo(inputTif);
    numberOfPages = length(info);
    gain = 1;
    for k=1:numberOfPages
        if mod(k-1,10)==0
            fprintf("%i/%i\n",k,numberOfPages);
        end
        thisPage = imread(inputTif,k).* gain;
        imshow(thisPage);
        title(sprintf("Frame No. %.0f, %s",k,file),'Interpreter', 'none');
        if k==1
            set(gcf,'Position',[0 0 500 500]);
        end
        exportgraphics(gcf,OutFile,'Append',true);
        hold on
        if ~isempty(inputTraj{k})
            scatter(inputTraj{k}(:,1), inputTraj{k}(:,2),3,"red");
        end
        exportgraphics(gcf,OutFile,'Append',true);
    end
end