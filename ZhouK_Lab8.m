function ZhouK_Lab8(A, filename)

% length of the matrix
size = length(A(1,:));

% initialize and populate the b vector
b = strings(size,1);
for i=1:size

    b(i) = ['b' num2str(i)];

end

% intialize the U, Ustar and L matrices
U = zeros(size);
Ustar = zeros(size);
L = zeros(size);

% for loop for incrementing the row
for k=1:size

    % ----------------- PIVOTING -----------------

    % edge case to deal with first row
    if k > 1

        % for loop for populating Ustar
        for r = k:size

            % calculate the first summation
            summation = dot(L(r,1:k-1),U(1:k-1,k));

            % populate the U matrix accordingly
            Ustar(r,k) = A(r,k) - summation;

        end

    else

        % col 1 of Ustar gets the value of col 1 of A
        Ustar(:,1) = A(:,1);

    end

    % determine the index of the greatest magnitude term in the rth col
    [~, pivot_target] = max(abs(Ustar(:,k)));
    
    % only swap rows if necessary
    if k~=pivot_target

        % perform the swap on the A matrix
        A([k pivot_target],:) = A([pivot_target k],:);

        % perform the swap on the U matrix
        L([k pivot_target],:) = L([pivot_target k],:);

        % perform the swap on the b vector
        b([k pivot_target],:) = b([pivot_target k],:);

    end

    % ----------------- POPULATING U -----------------

    % edge case to deal with first row
    if k > 1

        % for loop for implementing the row
        for c=1:size

            % condition for populating U
            if c >= k

                % calculate the first summation
                summation = dot(L(k,1:k-1),U(1:k-1,c));

                % populate the U matrix accordingly
                U(k,c) = A(k,c) - summation;

            end

        end

    else

        % row 1 of U gets the value of row 1 of A
        U(1,:) = A(1,:);

    end

    % ----------------- POPULATING L -----------------

    % edge case to deal with first row
    if k > 1

        % for loop for implementing the column
        for r=1:size

            % condition for populating L
            if r > k

                % calculate the second summation
                summation = dot(L(r,1:k-1),U(1:k-1,k));

                % populate the L matrix accordingly
                L(r,k) = (A(r,k) - summation) / U(k,k);

                % edge case to populate middle diagonal
            elseif r==k

                L(r,k) = 1;

            end

        end

    else

        % first term of l is the dot division
        L(:,1) = A(:,1)./A(1,1);

    end

end

% output the concatenated L U b matrix to a file
writematrix([L U b], filename);