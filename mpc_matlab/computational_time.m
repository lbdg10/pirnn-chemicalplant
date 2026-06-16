comp_time = zeros(size(out_tsolver,3),1);
for i=1:size(out_tsolver,3)
    comp_time(i,:) = out_tsolver(:,1,i);
end

avg_time = mean(comp_time(3:end))