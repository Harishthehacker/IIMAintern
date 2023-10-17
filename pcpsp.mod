
set B; # set of all blocks
param tmax; # number of time periods
param dmax; # number of possible destinations
param rmax; # number of resources
param q{B,rmax}; # amount of resource r required to extract block b
param Rmin{rmax,tmax}; # minimum amount of resource r that can be used in time period t
param Rmax{rmax,tmax}; # maximum amount of resource r that can be used in time period t
set P{B} within B; # set of precedences for each block a

var x{B,1..tmax} binary; # binary variable indicating if block b is extracted in time period t
var y{B,1..tmax,dmax} >= 0, <= 1; # continuous variable representing how much of block b to send to destination d in time period t

# objective function: maximize profit
maximize profit: sum {b in B, t in 1..tmax, d in 1..dmax} pb[b,t,d] * y[b,t,d];

# constraints
subject to precedence {a in B, b in P[a], t in 1..tmax}: sum {tt in 1..t} x[a,tt] <= sum {tt in 1..t} x[b,tt];
subject to extract_once {b in B}: sum {t in 1..tmax} x[b,t] <= 1;
subject to res_min {r in 1..rmax, t in 1..tmax}: sum {b in B, d in 1..dmax} q[b,r] * y[b,t,d] >= Rmin[r,t];
subject to res_max {r in 1..rmax, t in 1..tmax}: sum {b in B, d in 1..dmax} q[b,r] * y[b,t,d] <= Rmax[r,t];
subject to send_to_destinatioon {b in B, t in 1..tmax}: x[b,t] = sum {d in 1..dmax} y[b,t,d];
