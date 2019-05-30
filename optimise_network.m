function new_weights = optimise_network(s,t,weights,alarm_list,paths, num_nodes)
    % this function is used to locate affected links and update the weights
    % on the link with minimum traffic
    
    list_length = length(alarm_list);
    new_weights = weights;
    %num_nodes = 13;
    [paths_row, paths_column] = size(paths);
    adj_node1 = zeros(1,20); %on one end
    adj_node2 = zeros(1,20); %on the other end
    adj_node1_counter = zeros(1,num_nodes);
    adj_node2_counter = zeros(1,num_nodes);
    
    for i=1:list_length
        if (alarm_list(i) == 3)
            node1 = s(i);
            node2 = t(i);
            fprintf("the overutilised link is: %d \n", i);
%             [bool, locationn] = ismember([edge1, edge2], paths);
            disp('affected nodes');
            disp([node1, node2]);
            index1 = 1;
            index2 = 1;
            node1_new = node1;
            node2_new = node2;
            
            for j=1:paths_row
                for k=1:paths_column
                    if (paths(j,k)==node1)
                        if (paths(j,k+1)==node2 && k+1<=paths_column)
                            %adjacent node on end #1 located
                            if (k-1>=1)
                                adj_node1(index1) = paths(j,k-1); %note adjacent node
                                index1=index1+1;
                                adj_node1_counter(paths(j,k-1)) = adj_node1_counter(paths(j,k-1))+1;
                            end
                        elseif (k-1>=1 && paths(j,k-1)==node2)
                            %adjacent node on end #2 located
                            if (k-2>=1)
                                adj_node2(index2) = paths(j,k-2); %note adjacent node
                                index2=index2+1;
                                adj_node2_counter(paths(j,k-2)) = adj_node2_counter(paths(j,k-2))+1;
                            end
                        end
                    end
                end
            end
            disp('adjacent node 1:');
            disp(adj_node1);
            disp('adjacent node 2:');
            disp(adj_node2);
            disp('adjacent node 1 counter: ')
            disp(adj_node1_counter);
            disp('adjacent node 2 counter: ')
            disp(adj_node2_counter);

            adj_node1(adj_node1 == 0) = NaN;
            adj_node2(adj_node2 == 0) = NaN;
            if (min(adj_node1) == max(adj_node1) && nnz(adj_node1)>1) %check if there's only one neighbour on end #1
                adj_node1_counter_new = zeros(1,num_nodes);
                adj_node1_new = zeros(1,20); %on one end
                index1 = 1;
                for j=1:paths_row
                    for k=1:paths_column
                        if (paths(j,k)==node1)
                            if (paths(j,k+1)==node2 && k+1<=paths_column)
                                %adjacent node on end #1 located
                                if (k-2>=1)
                                    adj_node1_new(index1) = paths(j,k-2); %note 2nd neighbour node
                                    index1=index1+1;
                                    adj_node1_counter_new(paths(j,k-2)) = adj_node1_counter_new(paths(j,k-2))+1;
                                    node1_new = paths(j,k-1);
                                end
                            end
                        end
                    end
                end
                if (max(adj_node1_new) ~= 0)
                    adj_node1 = adj_node1_new;
                    adj_node1_counter = adj_node1_counter_new;
                end
            disp('adjacent node 1 NEW:');
            disp(adj_node1);
            disp('adjacent node 1 counter NEW: ')
            disp(adj_node1_counter);
            end
            
            if (min(adj_node2) == max(adj_node2) && nnz(adj_node2)>1) %check if there's only one neighbour on end #2
                adj_node2_counter_new = zeros(1,num_nodes);
                adj_node2_new = zeros(1,20); %on the other end
                index2 = 1;
                for j=1:paths_row
                    for k=1:paths_column
                        if (paths(j,k)==node1)
                            if (k-1>=1 && paths(j,k-1)==node2)
                                %adjacent node on end #2 located
                                if (k-3>=1)
                                    adj_node2_new(index2) = paths(j,k-3); %note adjacent node
                                    index2=index2+1;
                                    adj_node2_counter_new(paths(j,k-3)) = adj_node2_counter_new(paths(j,k-3))+1;
                                    node2_new = paths(j,k-2);
                                end
                            end
                        end
                    end
                end
                if (max(adj_node2_new) ~= 0)
                    adj_node2 = adj_node2_new;
                    adj_node2_counter = adj_node2_counter_new;
                end
                disp('adjacent node 2 NEW:');
                disp(adj_node2);
                disp('adjacent node 2 counter NEW: ')
                disp(adj_node2_counter);
            end
            
            %trying minimum instead, takes the 0s as min, so turn them NaN
            adj_node1_counter(adj_node1_counter == 0) = NaN;
            adj_node2_counter(adj_node2_counter == 0) = NaN;
            [adj_min1, adj_min1_index] = min(adj_node1_counter);
            [adj_min2, adj_min2_index] = min(adj_node2_counter);
            %adj_node1_counter(isnan(adj_node2_counter)) = 0;
            %adj_node2_counter(isnan(adj_node2_counter)) = 0;   %back to zeros
            
            if (isnan(adj_min1))
                adj_min1 = inf; %if the whole array is NaN then the following 'adj_min1 > adj_min2' messes up
            end
            if (isnan(adj_min2))
                adj_min2 = inf;
            end
            if (adj_min1 <= adj_min2)
                %new_weights(i) = new_weights(i)+1;
                for a=1:length(s)
                    if ((s(a) == node1_new && t(a) == adj_min1_index) || (t(a) == node1_new && s(a) == adj_min1_index) )
                        new_weights(a) = new_weights(a)+1; %spot the adjacent link on end #1 and increment its weight
                    end
                end
            else
                for a=1:length(s)
                    if ((s(a) == node2_new && t(a) == adj_min2_index) || (t(a) == node2_new && s(a) == adj_min2_index))
                        new_weights(a) = new_weights(a)+1; %spot the adjacent link on end #2 and increment its weight
                    end
                end
            end
            disp('new weights: ')
            disp(new_weights);
%             adj_node1 = zeros(1,10); %on one end
%             adj_node2 = zeros(1,10); %on the other end
%             adj_node1_counter = zeros(1,num_nodes);
%             adj_node2_counter = zeros(1,num_nodes);
        break;
        end
    end
end

