close all;
clear;

taus=5;
gsyn=7;

totalN = 3;

min_val = 0;
max_val = 1;
delta_val = (max_val-min_val)/(totalN-1);
val_list = (min_val:delta_val:max_val)';

res_list = zeros(totalN, 4);

for it=1:totalN
    gsyn_k = val_list(it)

    [n, W]=p1_ConnectivityMatrix(gsyn_k);
    [spiketimes]=p2_LIF2D_simple_network(n,W,gsyn,taus);

    % When running measures, ignore spikes in initial transient for time < 500 
    spiketimes = spiketimes(spiketimes(:,1)>500,:);

    % compute mean phase coherence
    [mean_mpc] = p3_mpc_network(n,spiketimes);
    
    % construct spiketime traces
    [traces,traces_all] = p3_spiketraces(n,spiketimes);

    % compute Golomb bursting measure
    [B] = p4_golomb_measure(n,traces,traces_all);
    
    % compute pairwise cross correlations with zero time lag
    [mean_crcorr, hub_mean_crcorr] = p4_crcorr_network(n,traces);

    % save results
    % res_list(it, :) = [mean_crcorr, hub_mean_crcorr, mean_mpc, B];
    res_list(it, :) = [mean_crcorr, hub_mean_crcorr];
    % res_list(it, :) = [B];
    % res_list(it, :) = [mean_mpc];
end

close all;
plot(val_list, res_list,'LineWidth',2);
title('Synchrony in hub-network', 'Interpreter', 'latex');
xlabel('Ratio of interhub v/s intrahub connectivity', 'Interpreter', 'latex');
% ylabel('Mean Phase Coherence', 'Interpreter', 'latex');
% ylabel('Golomb Bursting measure', 'Interpreter', 'latex');
ylabel('Cross Correlation', 'Interpreter', 'latex');
legend('Overall','Hub');