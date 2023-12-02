function TrajectoryData = ParticleTracker(OutputTable)
    ToTrack = OutputTable;
    TrackedParticleData = {};
    t = 1;
    time = ToTrack.ImageNumber;
    ParticleNumber = ToTrack.ObjectNumber;
    PositionX = ToTrack.Location_Center_X;
    PositionY = ToTrack.Location_Center_Y;
    Persistence = ToTrack.TrackObjects_Lifetime_30;
    %filenames = ToTrack.FileName_OrigColor;
    TrajectoryData={};
    curr = 0;
    i=1;
    l = time(end);

    while i<=length(time)
        if mod(curr,100)==0
            fprintf("%i/%i\n", curr, l);
        end
        Positions = [];
        while (i <= length(time)) && (curr==time(i))
            Positions(ParticleNumber(i),1:3)=[PositionX(i),PositionY(i),Persistence(i)];
            i = i+1;
        end
        TrajectoryData{curr+1}=Positions;
        curr = curr+1;
    end
    TrajectoryData(1)=[];
end