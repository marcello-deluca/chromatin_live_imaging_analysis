figure();
hold on;
correctedSEM={};
xvals = {};
for i=1:length(MSDS)
    plot([0;nonzeros(MSDS{i})]);
end

MeanMSD=zeros(1001,1);
counts = zeros(1000,1);
for i=1:1000
    for j=1:length(MSDS)
        if ~isnan(MSDS{j}(i)) && MSDS{j}(i)>0
            counts(i)=counts(i)+1;
            MeanMSD(i)=MeanMSD(i)+MSDS{j}(i);
        end
    end
    if counts(i)>0
        MeanMSD(i)=MeanMSD(i)/counts(i);    
    end
end

for j=1:length(MSDS)
     correctedSEM{i} = std(nonzeros(MSDS{j}));
     xVals{i} = 1:length(correctedSEM{i});
end

figure();
plot([0;nonzeros(MeanMSD)]);
xlim([0 25]);