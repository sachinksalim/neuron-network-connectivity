function [mean_crcorr, hub_mean_crcorr] = p4_crcorr_network(n,traces)

hub_mean_crcorr = [];

for i=1:10:n
    cell_pairs = [];
    
    for l=i+1:i+9
        cell_pairs = [cell_pairs; [i, l]];
    end

    crcorr_cellpairs = zeros(length(cell_pairs),1);

    for j=1:length(cell_pairs)
        crcorr_cellpairs(j) = xcorr(traces(cell_pairs(j,1),:),traces(cell_pairs(j,2),:),0,'coeff');
    end
    
    crcorr_cellpairs_real = crcorr_cellpairs(~isnan(crcorr_cellpairs));
    
    mean_crcorr = mean(crcorr_cellpairs_real);
    
    hub_mean_crcorr = [hub_mean_crcorr; mean_crcorr];
end

for i = 1:n
    temp1 = i*ones(n-1,1);
    temp2 = (1:n)'; 
    temp2 = temp2(temp2~=i);
    temp = [temp1, temp2];
    if i == 1
        cell_pairs = temp;
    else
        cell_pairs = [cell_pairs; temp];
    end
end
    
crcorr_cellpairs = zeros(length(cell_pairs),1);

for j=1:length(cell_pairs)
    crcorr_cellpairs(j) = xcorr(traces(cell_pairs(j,1),:),traces(cell_pairs(j,2),:),0,'coeff');
end

crcorr_cellpairs_real = crcorr_cellpairs(~isnan(crcorr_cellpairs));

mean_crcorr = mean(crcorr_cellpairs_real);

end