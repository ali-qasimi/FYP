function alarm_list = alarm(utilisation_list)
    % this function assigns an alarm state to each link in the network
    %0: not utilised
    %1: green
    %2: yellow
    %3: red
    list_length = length(utilisation_list);
    capacity = 10; %say 10GB/s
    
    alarm_list = zeros(1,list_length); %same size as the link matrix
    
    for i=1:list_length
        if utilisation_list(i) < 0.8*capacity
            alarm_list(i) = 1;  %green
        elseif (utilisation_list(i) >= 0.8*capacity && utilisation_list(i) < capacity)
            alarm_list(i) = 2; %yellow
        elseif utilisation_list(i) >= capacity
            alarm_list(i) = 3; %red
        end  
    end
end

