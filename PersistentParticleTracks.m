function [uneditedTracks,tracks,origintime] = PersistentParticleTracks(TrajectoryData,filename)
    persistence_threshold = 2;
    upper_persistence_threshold = 10;
    jump_threshold = 20;
    minDiffusionThreshold=15;
    origintime = [];
    tracks = {};
    lTrack = length(TrajectoryData);
    n = 1;
    toDelete = [];
    for i=1:lTrack
        if isempty(TrajectoryData{i})
            toDelete = [toDelete,i];
        end
    end
    TrajectoryData(toDelete)=[];
    lTrack = length(TrajectoryData);
    for i=1:lTrack
        %if ~isempty(TrajectoryData{i})
            %fprintf("%i: ",i);
       % end
        frame = TrajectoryData{i};
        szf = size(frame);
        for j=1:szf(1)
            if frame(j,3)==1
                k=i;
                xTrack = [];
                yTrack = [];
                lifetime = 1;
                xTrack(1)=frame(j,1);
                yTrack(1)=frame(j,2);
%                 if (k<lTrack)
%                     sz = size(TrajectoryData{k+1});
%                 end
%                 
%                 for q=1:length(sz)
%                     fprintf("%i,",sz(q));
%                 end
               % fprintf("\n");
                if (k<lTrack)
                    szt = size(TrajectoryData{k+1});
                end
                while (k<lTrack) && (j <= szt(1)) && (TrajectoryData{k+1}(j,3)>TrajectoryData{k}(j,3))
                    k = k + 1;
                    curr = TrajectoryData{k};
                    lifetime = lifetime + 1;
                    xTrack(lifetime)=curr(j,1);
                    yTrack(lifetime)=curr(j,2);
                    if (k+1 <= length(TrajectoryData))
                        szt = size(TrajectoryData{k+1});
                    end
                end
                track = [xTrack;yTrack];
                n = n + 1;
                tracks{end+1} = track;
            end
        end
    end

    uneditedTracks = tracks;
    hold on
    IndicesToDelete = [];
    for i=1:length(tracks)
        if length(tracks{i}) <= persistence_threshold || length(tracks{i}) > upper_persistence_threshold
            IndicesToDelete = [IndicesToDelete, i];
        end
    end
    tracks(IndicesToDelete)=[];
    figure()
    hold on 
    for i=1:length(tracks)
        curr = tracks{i};
        plot(curr(1,:),curr(2,:));
    end

    title(filename,'Interpreter', 'none');
    
    
    
    
    
    
    %Now tear apart tracks that jump
    jumps = 1000;
    while max(jumps) > jump_threshold
        jumps = [];
        i = 1;
        while i <= length(tracks)
            t = tracks{i};
            szt = size(t);
            j = 1;
            while j < szt(2)
                jump = norm(t(:,j+1) - t(:,j));
                jumps = [jumps,jump];
                if jump > jump_threshold
                    new = t(:,j+1:end);
                    szn = size(new);
                    if szn(2) >= persistence_threshold
                       tracks{end+1} = new; 
                    end
                    tracks{i}(:,j:end) = [];
                    %plot(tracks{end}(1,:),tracks{end}(2,:));
                    %hold on
                    %plot(tracks{i}(1,:),tracks{i}(2,:))
                    break
                end
                j = j+1;
                szt = size(t);
            end
            i = i+1;
        end
        IndicesToDelete = [];
        for i = 1:length(tracks)
            szt = size(tracks{i});
            if szt(2) <= persistence_threshold
                IndicesToDelete = [IndicesToDelete, i];
            end
        end
        tracks(IndicesToDelete) = [];
    end
    
    indicesToDelete = [];
    for i=1:length(tracks)
        curr = tracks{i};
        currend = [curr(1,end),curr(2,end)];
        currbegin = [curr(1,1),curr(2,1)];
        if norm(currbegin-currend) < minDiffusionThreshold
            IndicesToDelete = [IndicesToDelete, i];
        end
    end
    tracks(IndicesToDelete) = [];

    figure()
    hold on 
    for i=1:length(tracks)
        curr = tracks{i};
        plot(curr(1,:),curr(2,:));
    end
    axis equal
    title(filename,'Interpreter', 'none');
    %fprintf("\n\n\n");

end

