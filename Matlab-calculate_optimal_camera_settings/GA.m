%genetic algorithm
Pop_Num=20;
Pop=RandomPopCreate(Pop_Num);
Gen=1;
ITER=20;
while Gen<=ITER
    Gene_Sequence=randperm(Pop_Num);
    k=1;
    while k<Pop_Num
        i=Gene_Sequence(k);
        j=Gene_Sequence(k+1);
        X_i=Pop{i};
        X_j=Pop{j};
        [X_i,X_j]=Crossover(X_i,X_j);
        X_i=Mutate(X_i);
        X_j=Mutate(X_j);
        Pop=[Pop,{X_i},{X_j}];
        k=k+2;
    end
    Pop=Reselect(Pop,Pop_Num);
    X_opt=Pop{1};
    IU_growth_GA(Gen)=IU(X_opt)
    Gen=Gen+1
    i_lmd
end
display('GA is over,optimal value: ');
%plot(1:ITER,IU_growth_GA);
sol_GA=IU_growth_GA(ITER);

