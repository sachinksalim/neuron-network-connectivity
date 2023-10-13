close all;
clear;

taus=5;
gsyn=7;
gsyn_k=0;

totalN = 5;
min_val = 0;
max_val = 1;

delta_val = (max_val-min_val)/(totalN-1);
val_list = (min_val:delta_val:max_val)';

res_list = zeros(totalN, 2);

for it=1:totalN
    gsyn_k = val_list(it)
    [n, W]=p1_ConnectivityMatrix(gsyn_k);
    [spiketimes]=p2_LIF2D_simple_network(n,W,gsyn,taus);
    [timevec,traces,traces_all] = p3_spiketraces(n,spiketimes);
    [mean_mpc, mpc_cellpairs] = p3_mpc_network(n,spiketimes);
    [mean_crcorr, hub_mean_crcorr] = p4_crcorr_network(n,traces);
    res_list(it, :) = [mean_crcorr, hub_mean_crcorr];
end

close all;
plot(val_list, res_list,'LineWidth',2);
title('Synchrony in hub-network', 'Interpreter', 'latex');
xlabel('gsyn\_k (Ratio of interhub v/s intrahub gsyn)', 'Interpreter', 'latex');
ylabel('Cross Correlation', 'Interpreter', 'latex');
legend('Overall','Hub');