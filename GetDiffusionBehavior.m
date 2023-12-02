function [MSD,SEM,len] = GetDiffusionBehavior(tracks)
    SDS = cell(1,1000);
    for i=1:length(tracks)
        curr = tracks{i};
        for tstart = 1:(length(curr)-1)
            for dt = 1:(length(curr)-tstart)
                SDS{dt}(end+1)=norm(curr(:,tstart+dt)-curr(:,tstart))^2;
            end
        end
    end
    
    for i=1:length(SDS)
        MSD(i)=mean(SDS{i});
        SEM(i)=std(SDS{i})/sqrt(length(SDS{i}));
        len(i)=length(SDS{i});
    end
    %hold on
    %shadedErrorBar(1:length(SDS),MSD,SEM,'Color','red');
end
