function label_list = network_label(utilisation_list,weights,capacity)
    %this function is used to create a list of labels corresponding to the
    %links in s and t. 
    
    label_list = {'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'};
    
    for i=1:length(utilisation_list)
        utilisation_str = num2str(utilisation_list(i)/capacity*100);  %convert to string and into percentage
        weight_str = num2str(weights(i));
        label_list{i} = strcat(utilisation_str,'%,',weight_str);  
    end
end