function utilisation_matrix = utilisation(num_nodes,paths)
    %outputs a matrix similar to the link matrix, except it displays the
    %number of connections happening on that link.
    
    utilisation_matrix = zeros(num_nodes,num_nodes);
    [rows, columns] = size(paths);
    
    for i=1:rows
        for j=1:columns
            if paths(i,j+1)~=0
                utilisation_matrix(paths(i,j),paths(i,j+1))=utilisation_matrix(paths(i,j),paths(i,j+1))+1; 
                %go to each element in the paths matrix and find what's its
                %next node, then use those two values as the target index
                %in the utilisation matrix to increment.
                
                %disp('utilisation_matrix: ')
                %disp(utilisation_matrix);
            else
                break;
            end
        end
    end
end