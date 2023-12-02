function NewOutput = InvestigateBadTracks(Tracks,resultFile)
    fileID = fopen(resultFile,'w');
    NewOutput = Tracks;
    sz = size(Tracks);
    figure();
    for i=1:sz(2)
        fprintf("Now entering track %i\n",i);
        szt = size(Tracks{i});
        to_delete = [];
        for j=1:szt(2)
            plot(Tracks{i}{j}(1,:),Tracks{i}{j}(2,:));
            good_input = false;
            while ~good_input
                ok = input("is the track ok?","s");
                switch ok
                    case "y"
                        %do nothing
                        good_input=true;
                    case "n"
                        to_delete = [to_delete,j];
                        good_input=true;
                    otherwise
                        fprintf("bad input\n");
                end
            end
        end
        NewOutput{i}(to_delete)=[];
        fprintf(fileID,"erased tracks %d from set %i \n",to_delete,i);
    end
    fclose(fileID);
end