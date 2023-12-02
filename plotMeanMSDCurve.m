function [SDS, MultiMSD, MultiSEM] = plotMeanMSDCurve(MultiTracks)
    MultiMSD = [];
    MultiSEM = [];
    SDS = cell(1000,1);
    CorrectedSEM = cell(1000,1);
    sz = size(MultiTracks);
    for n=1:sz(2)
        Curr = MultiTracks{n};
        szn = size(Curr);
        for i=1:szn(2)
            currTrack = Curr{i};
            for tstart = 1:length(currTrack)-1
                for dt = 1:(length(currTrack)-tstart)
                    SD = norm(currTrack(:,tstart+dt)-currTrack(:,tstart))^2;
                    SDS{dt}(end+1) = SD;
                end
            end
        end
    end
    
    for i = 1:1000
        MultiMSD(i) = mean(nonzeros(SDS{i}));
        MultiSEM(i) = std(nonzeros(SDS{i}))/sqrt(length(nonzeros(SDS{i})));
    end
    
    
    
    figure();
    shadedErrorBar(0:length(MultiMSD),[0,MultiMSD],[0,MultiSEM]);
    xlim([0 25]);
end