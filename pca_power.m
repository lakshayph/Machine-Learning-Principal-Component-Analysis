function pca_power( training_file, test_file, m, iterations)
training_data  = importdata(training_file);
test_data = importdata(test_file);
size_projection = str2double(m);
num_iterations = str2double(iterations);
num_columns = size(training_data,2); 
num_rows = size(test_data,1);
training = zeros(size(training_data,1),num_columns-1);
test = zeros(size(test_data,1),num_columns-1);
storage = zeros(size_projection,size(training,2));
storage_test1 = zeros(size(test_data,1),size_projection);

    for j=1:num_columns-1
        training(:,j) = training_data(:,j);
        test(:,j) = test_data(:,j);
    end
    
initial_matrix = training;

    for j=1:size_projection
        b = rand(size(training,2),1);
        s = cov(initial_matrix);
        for k =1:num_iterations
            v = s * b;
            q = norm(v);
            b = v/q; 
        end
        u = b; 
        initial_matrix = initial_matrix - ((initial_matrix*u)*u');
        storage(j,:) = u(:,1);
    end
        
    for i = 1:size_projection
        fprintf('Eigenvector %5d\n',i)
        for k = 1:size(storage,2)
            fprintf('%3d: %.4f\n',k, storage(i,k));
        end
    end
    
    for j = 1:num_rows 
        for i = 1:size_projection
           storage_test1(j,i) = test(j,:)*storage(i,:)';
        end
    end
    
    for j = 1:num_rows
        fprintf('Test Object %5d \n',j-1);
        for i = 1:size_projection
            fprintf('%3d: %.4f\n',i,storage_test1(j,i));
        end
    end
end