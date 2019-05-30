clc
clear all
close all

tic

%NFS Net, size = small
x = [5.17, 1.76, 4.11, 7.49, 10.86, 17.15, 17.78, 22.66, 26.89, 23.84, 26.28, 32.00, 31.99]; %position of nodes
y = [15.48, 9.84, 4.18, 11.22, 8.13, 2.27, 7.06, 7.05, 9.58, 13.07, 18.00, 13.97, 6.24];

num_nodes = 13;

s = [2 3 3 4 5 6 6 7 8 8 9 10 11 11 12 12 13 13]; %other way to represent link Matrix. Lists connection sources (verticals) until diagonal
t = [1 1 2 2 4 3 5 5 1 7 8 4 9 10 9 10 6 11]; %targets corresponding to each source in s, lists connections to targets


% %Telecom Italia                    5                                  10                               15                                 20                                25                                30                                35                              40                         44             
% x = [0.870, 2.140, 2.140, 1.390, 3.170, 3.500, 3.340, 4.400, 4.630, 4.530, 5.410, 5.810, 5.220, 5.74, 6.750, 7.120, 6.700, 6.300, 5.790, 7.450, 7.20, 7.670, 9.120, 8.30, 9.120, 9.710, 11.08, 13.78, 14.75, 14.27, 11.66, 9.44, 8.85, 12.93, 11.08, 8.18, 7.570, 6.610, 1.97, 2.52, 3.55, 7.800, 8.160, 10.02];
% y = [18.08, 19.02, 17.84, 16.40, 16.62, 17.81, 19.39, 19.27, 17.70, 15.32, 17.06, 18.20, 18.87, 20.6, 20.57, 19.51, 18.33, 16.43, 15.37, 16.29, 17.2, 18.28, 18.97, 20.1, 14.90, 13.16, 11.80, 10.15, 9.040, 6.250, 3.520, 2.68, 4.32, 6.340, 10.34, 12.5, 14.08, 12.34, 9.50, 6.72, 9.31, 11.59, 10.61, 9.680];
% % y = [3.92, 2.98, 4.16, 5.60, 5.38, 4.19, 2.61, 2.73, 4.30, 6.68, 4.94, 3.80, 3.13, 1.40, 1.43, 2.49, 3.67, 5.57, 6.63, 5.71, 4.80, 3.72, 3.03, 1.90, 7.10, 8.84, 10.20, 11.85, 12.96, 15.75, 18.48, 19.32, 17.68, 15.66, 11.66, 9.50, 7.92, 9.66, 12.50, 15.28, 12.69, 10.41, 11.39, 12.32];
% num_nodes = 44;
% s = [1, 1, 1, 2, 2, 3, 3, 4, 5,  5, 6, 7, 7,  7,  8,  9, 9,  10, 10, 11, 11, 12, 12, 12, 14, 15, 16, 16, 17, 17, 17, 18, 18, 19, 19, 20, 20, 21, 22, 23, 25, 25, 26, 26, 27, 27, 28, 28, 29, 30, 30, 31, 31, 31, 33, 32,  34, 34, 35, 35, 36, 36, 36, 38, 38, 39, 39, 40, 41, 42, 43];
% t = [2, 3, 4, 6, 7, 5, 6, 5, 6, 10, 9, 8, 9, 12, 13, 10, 11, 19, 38, 12, 18, 13, 14, 17, 15, 16, 22, 24, 18, 21, 22, 19, 20, 36, 37, 21, 25, 22, 23, 24, 26, 37, 27, 42, 28, 35, 29, 35, 30, 31, 34, 32, 33, 34, 34, 33,  35, 44, 36, 44, 37, 38, 42, 39, 42, 40, 41, 41, 43, 43, 44];

% make a square 7 by 7 network so there's no central link?
% x = [1,2,3,4,5,6,7, ...
%      1,2,3,4,5,6,7, ...
%      1,2,3,4,5,6,7, ...
%      1,2,3,4,5,6,7, ...
%      1,2,3,4,5,6,7, ...
%      1,2,3,4,5,6,7, ...
%      1,2,3,4,5,6,7];
%  y = [1,1,1,1,1,1,1, ...
%       2,2,2,2,2,2,2, ...
%       3,3,3,3,3,3,3, ...
%       4,4,4,4,4,4,4, ...
%       5,5,5,5,5,5,5, ...
%       6,6,6,6,6,6,6, ...
%       7,7,7,7,7,7,7];
%   
% num_nodes = 49;
% s = [1, 1, 2, 2, 3,  3, 4,  4, 5,  5, 6,  6,  7, 8,  8, 9,   9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 15, 15, 16, 16, 17, 17, 18, 18, 19, 19, 20, 20, 21, 22, 22, 23, 23, 24, 24, 25, 25, 26, 26, 27, 27, 28, 29, 29, 30, 30, 31, 31, 32, 32, 33, 33, 34, 34, 35, 36, 36, 37, 37, 38, 38, 39, 39, 40, 40, 41, 41, 42, 43, 44, 45, 46, 47, 48];
% t = [2, 8, 3, 9, 4, 10, 5, 11, 6, 12, 7, 13, 14, 9, 15, 10, 16, 11, 17, 12, 18, 13, 19, 14, 20, 21, 16, 22, 17, 23, 18, 24, 19, 25, 20, 26, 21, 27, 28, 23, 29, 24, 30, 25, 31, 26, 32, 27, 33, 28, 34, 35, 30, 36, 31, 37, 32, 38, 33, 39, 34, 40, 35, 41, 42, 37, 43, 38, 44, 39, 45, 40, 46, 41, 47, 42, 48, 49, 44, 45, 46, 47, 48, 49];

capacity = 10; %say 10GB/s
num_links = length(s);
weights = ones(1, num_links); %weights are in order of node numbers
figure(1);
G = graph(s, t, weights);
%plot1 = plot(G, 'XData', x, 'YData', y, 'EdgeLabel', G.Edges.Weight);
plot1 = plot(G, 'XData', x, 'YData', y);
title("Before Optimisation");


num_connections = 30;
%output for console
targets = randi([1,num_nodes],1,num_connections);
sources = randi([1,num_nodes],1,num_connections);
%to create overutilisation
outlier_source = randi([1,num_nodes]);
outlier_target = randi([1,num_nodes]);
for i=1:3
    sources(num_connections+i)=outlier_source;
    targets(num_connections+i)=outlier_target;
end
targets_count = length(targets);
paths = zeros(targets_count,20);

for i = 1:targets_count
    if (sources(i) ~= targets(i))
        [p,d] = shortestpath(G, sources(i), targets(i)); %get path matrix (p) and distance (d)
    end
    for j=1:length(p)
        paths(i,j) = p(j);
    end
end

disp('targets: ');
disp(targets);
disp('paths: ');
disp(paths);

utilisation_matrix = utilisation(num_nodes,paths);
%converting from utilisation matrix to utilisation list corresponding to s
%and t.
utilisation_list = zeros(1,num_links);
utilisation_list_tx = zeros(1,num_links);
utilisation_list_rx = zeros(1,num_links);
for i = 1:num_links
    if (utilisation_matrix(s(i),t(i)) ~= 0)
        utilisation_list(i) = utilisation_list(i) + utilisation_matrix(s(i),t(i));
        utilisation_list_tx(i) = utilisation_matrix(s(i),t(i));
    end
    if (utilisation_matrix(t(i),s(i)) ~= 0)
        utilisation_list(i) = utilisation_list(i) + utilisation_matrix(t(i),s(i));
        utilisation_list_rx(i) = utilisation_matrix(t(i),s(i));
    end
end
disp('utilisation_list: ');
disp(utilisation_list);
disp('tx: ')
disp(utilisation_list_tx);
disp('rx: ')
disp(utilisation_list_rx);

label_list = network_label(utilisation_list, weights, capacity);
disp('label_list: ');
disp(label_list);
labeledge(plot1,s,t,label_list);  %label the edges with percentage utilisation and weight


alarm_list = alarm(utilisation_list);
disp('alarm_list: ')
disp(alarm_list);

%highlighting the overutilised links
for i=1:length(alarm_list)
    if (alarm_list(i) == 3)
        highlight(plot1,[s(i), t(i)],'EdgeColor','r','LineWidth',1.5);
    elseif (alarm_list(i) == 2)
        highlight(plot1,[s(i), t(i)],'EdgeColor',[1 0.5 0],'LineWidth',1.5);
    else 
        highlight(plot1,[s(i), t(i)],'EdgeColor','g','LineWidth',1.5);
    end
end


%% after optimising the network

%output for console
new_weights = ones(1, num_links);
G_new = graph(s, t, new_weights);
new_weights = optimise_network(s,t,weights,alarm_list,paths,num_nodes);

isalarm3 = 1;
threshold = 1;
if (num_links > 30)
    threshold_max = 15;
else 
    threshold_max = 5;
end

while (isalarm3==1 && threshold <= threshold_max)
    %keep adjusting the weights until there's no red alarms
    threshold = threshold + 1;
    
    paths_new = zeros(targets_count,20);
    for i = 1:targets_count
        if (sources(i) ~= targets(i))
            [p_new,d_new] = shortestpath(G_new, sources(i), targets(i)); %get path matrix (p) and distance (d)
        end
        for j=1:length(p_new)
            paths_new(i,j) = p_new(j);
        end
    end

    disp('paths_new: ');
    disp(paths_new);

    utilisation_matrix_new = utilisation(num_nodes,paths_new);
    %converting from utilisation matrix to utilisation list corresponding to s
    %and t. 
    utilisation_list_new = zeros(1,num_links);
    utilisation_list_tx_new = zeros(1,num_links);
    utilisation_list_rx_new = zeros(1,num_links);
    for i = 1:num_links
        if (utilisation_matrix_new(s(i),t(i)) ~= 0)
            utilisation_list_new(i) = utilisation_matrix_new(s(i),t(i));
            utilisation_list_tx_new(i) = utilisation_matrix_new(s(i),t(i));
        end
        if (utilisation_matrix_new(t(i),s(i)) ~= 0)
            utilisation_list_new(i) = utilisation_list_new(i) + utilisation_matrix_new(t(i),s(i));
            utilisation_list_rx_new(i) = utilisation_matrix_new(t(i),s(i));
        end
    end

    alarm_list_new = alarm(utilisation_list_new);
    for i=1:length(alarm_list)
        if (alarm_list_new(i) == 3)
            isalarm3 = 1;
            break;
        elseif (i == length(alarm_list))
            isalarm3 = 0;
        end
    end
    
    figure;
    plot2 = plot(G_new, 'XData', x, 'YData', y);
    title("After Optimisation");
    
    disp('alarm_list_new: ');
    disp(alarm_list_new);
    disp('utilisation_list_new: ');
    disp(utilisation_list_new);
    label_list_new = network_label(utilisation_list_new, new_weights, capacity);
    disp('label_list_new: ');
    disp(label_list_new);
    labeledge(plot2,s,t,label_list_new);  %label the edges with percentage utilisation and weight



    %colour coding the links according to the alarm category
    for i=1:length(alarm_list_new)
        if (alarm_list_new(i) == 3)
            highlight(plot2,[s(i), t(i)],'EdgeColor','r','LineWidth',1.5);
        elseif (alarm_list_new(i) == 2)
            highlight(plot2,[s(i), t(i)],'EdgeColor',[1 0.5 0],'LineWidth',1.5);
        else 
            highlight(plot2,[s(i), t(i)],'EdgeColor','g','LineWidth',1.5);
        end
    end
    
    if (isalarm3 == 1)
        new_weights = optimise_network(s,t,new_weights,alarm_list_new,paths_new,num_nodes);
        G_new = graph(s, t, new_weights);
    end



end

toc

time = toc;
%disp(toc);