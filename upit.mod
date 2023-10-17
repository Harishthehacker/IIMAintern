
param n_blocks;
param pre_blocks;

set B:= 1..n_blocks; #Set of all blocks

param P; #Precedences of block a

param pb{B}; #Profit obtained from including block b in the pit

var X{B} binary; #Binary variable indicating if block B should be included in the ultimate pit or not

maximize Profit: sum{b in B} pb[b] * X[b];

#subject to Precedences{a in B, b in B: P{a,b}=1}: X[a]<=X[b];
subject to Precedences: X[19]<=X[1];
