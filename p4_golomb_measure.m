function [B] = p4_golomb_measure(n,traces,traces_all)
    % compute Golomb bursting measure
    sigma = zeros(n,1);
    for i=1:n
        sigma(i) = var(traces(i,:));
    end
    sigma_all = var(traces_all);
    B = sigma_all/mean(sigma);
end