function [X_i_out,X_j_out]=Crossover(X_i_in,X_j_in)
num_U=10;
loc=randi(num_U-1);
X_i_out=[X_i_in(1:loc,:);X_j_in(1:num_U-loc,:)];
X_j_out=[X_i_in(loc+1:num_U,:);X_j_in(num_U-loc+1:num_U,:)];

end