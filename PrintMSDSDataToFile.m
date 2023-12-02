textfile = "results.txt";
fileID = fopen(textfile,'w');
fprintf(fileID, "t Mean1 Mean2 Mean3 Mean4 Mean5 Mean6 Mean7 Mean8 Overall\n");
for j=1:16
    fprintf(fileID, "%i %f %f %f %f %f %f %f %f %f\n", j, MSDS{1}(j), MSDS{2}(j), MSDS{3}(j), MSDS{4}(j), MSDS{5}(j), MSDS{6}(j), MSDS{7}(j), MSDS{8}(j), MultiMSD(j));
end