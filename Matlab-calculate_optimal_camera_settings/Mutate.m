function X_out=Mutate(X_in)

global R_of_I;
num_U=10;
x_min=-30;
x_max=30;
y_min=-30;
y_max=30;
z_min=33;
z_max=43;

loc=randi(num_U);

l=[randi([x_min,x_max]),randi([y_min,y_max]),randi([z_min,z_max])];
d=randi(size(R_of_I,1));
f=4.15/1000;
U_random=[l,R_of_I(d,:),f];

X_out=X_in;
X_out(loc,:)=U_random;

end