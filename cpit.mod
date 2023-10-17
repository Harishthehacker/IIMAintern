param n_blocks;
set B := 1..n_blocks; #set of all blocks

param tmax; #number of time periods
param rmax; #number of resources
param pb{B,1..tmax};#Profit obtained from including block b in the pit
param q{B,1..rmax}; #amount of resource r required to extract block b
param Rmin{1..rmax,1..tmax}; #minimum amount of resource r that can be used in time period t
param Rmax{1..rmax,1..tmax}; #maximum amount of resource r that can be used in time period t

set P{B}; #set of precedences for each block a

var x{B,1..tmax} binary; #binary variable indicating if block b is extracted in time period t

#Objective function -> To maximize profit
maximize profit: sum {b in B, t in 1..tmax} pb[b,t] * x[b,t];

#Constraints
subject to precedence{a in B, b in P[a], t in 1..tmax}: sum {tt in 1..t} x[a,tt] <= sum {tt in 1..t} x[b,tt];
subject to extract_once{b in B}: sum {t in 1..tmax} x[b,t] <= 1;
subject to res_min{r in 1..rmax, t in 1..tmax}: sum {b in B} q[b,r] * x[b,t] >= Rmin[r,t];
subject to res_max{r in 1..rmax, t in 1..tmax}: sum {b in B} q[b,r] * x[b,t] <= Rmax[r,t];

