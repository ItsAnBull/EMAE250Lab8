function ZhouK_Lab8(A, filename)

% length of the matrix
size = length(A(1,:));

% summation variable
summation = 0;

% intialize the u and l matrices
U = zeros(size);
L = zeros(size);

% for loop for incrementing the row
for r=1:size

    % edge case to deal with first row
    if r > 1

        % for loop for implementing the column
        for c=1:size

            % condition for populating U
            if c >= r

                % calculate the first summation
                summation = dot(L(r,1:r-1),U(1:r-1,c));

                % populate the U matrix accordingly
                U(r,c) = A(r,c) - summation;

            end

            % condition for populating L
            if c < r

                % calculate the second summation
                summation = dot(L(r,1:c-1),U(1:c-1,c));

                % populate the L matrix accordingly
                L(r,c) = (A(r,c) - summation) / U(c,c);
            
            % edge case to populate middle diagonal
            elseif c==r

                L(r,c) = 1;

            end

        end

    else

        % row 1 of U gets the value of row 1 of A
        U(1,:) = A(1,:);

        % first term of l is the dot division
        L(:,1) = A(:,1)./A(1,1);

    end


end

L
U