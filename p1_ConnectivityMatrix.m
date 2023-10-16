function [n, W]=p1_ConnectivityMatrix(gsyn_k)
% gsyn_k: Ratio of interhub gsyn v/s intrahub gsyn

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set up connectivity matrix W

% 1D ring network
% set network size n 
n = 50;

if nargin < 1 || isempty(gsyn_k)
    gsyn_k = 0;  % Set default value for gsyn_k
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % nearest neighbor coupling
% % set radius of connectivity crad, # of outgoing synapses per neuron =
% % 2*crad

% crad = 1;
% 
% W = zeros(n);
% for k=1:crad
%     W = W +diag(ones(n-k,1),k)+diag(ones(n-k,1),-k);
% end
% 
% % add synapses to end cells = periodic boundary conditions
% for k=crad:-1:1
%     for j=crad:-1:k
%         W(n-(j-k),k) = 1;
%         W(k,n-(j-k)) = 1;
%     end
% end
% clear crad j k
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % all-to-all coupling
% W = ones(n);
% W = W - diag(ones(n,1));
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% random sparse connectivity with 2*crad outgoing synapses per neuron
% start with all-to-all coupling and set n-2*crad synapses to zero
hub_count=5;
% hub_size = n/hub_count;

W = zeros(n);

% intra-hub
for i=1:5
    for j=1:9
        W((i-1)*10+j+1,1+10*(i-1)) = 1;
        W(1+10*(i-1),(i-1)*10+j+1) = 1;
    end
end

%inter-hub
for i=1:5
    for j=1:5
        if i ~= j
            W((i-1)*10+1,(j-1)*10+1) = gsyn_k;
        end
    end
end
clear i j
% % % % % % 

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % random sparse connectivity with 2*crad outgoing synapses per neuron
% % start with all-to-all coupling and set n-2*crad synapses to zero
% crad=20;
% 
% W = ones(n);
% W = W - diag(ones(n,1));
% 
% %loop through rows of W
% for i=1:n
%     % randomly determine which synaptic connections to zero out
%     allconnects = randperm(n);
%     noconnect=allconnects(1:(n-1)-2*crad);
%     %Errorcheck so autapses are not included
%     checki=find(noconnect==i);
%     if ~isempty(checki)
%         noconnect(checki)=allconnects(n-2*crad+1);
%     end
%     % zero out synaptic connections
%     W(i,noconnect) = 0;
%     
% end
% clear crad allconnects noconnect checki i
% % % % % % 

figure(1)
imshow(W, 'InitialMagnification', 'fit');
% colormap([0 0 0; 1 1 1]);
title('Connectivity Matrix (W)');

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end