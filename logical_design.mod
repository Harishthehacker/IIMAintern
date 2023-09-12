param N_gates;
param N_inputs;
param N_rows;

set GATES := 1..N_gates;
set INPUTS := 1..N_inputs;
set ROWS := 1..N_rows;
param alpha{INPUTS, ROWS};

var s{GATES} binary;
var t{GATES, INPUTS} binary;
var x{GATES, ROWS} binary;

#objective function
minimize obj: sum{i in GATES} s[i];

#Constraints
subject to
c1{i in GATES}: s[i] - t[i,1] >= 0;
c2{i in GATES}: s[i] - t[i,2] >= 0;
c3{i in 1..3}: s[2*i] + s[2*i+1] + t[i,1] + t[i,2] <= 2;
c4{i in 1..3, l in ROWS}: x[2*i,l] + x[i,l] <= 1;
c5{i in 1..3, l in ROWS}: x[2*i+1,l] + x[i,l] <= 1;
c6{i in GATES, l in ROWS}: alpha[1,l]*t[i,1] + x[i,l] <= 1;
c7{i in GATES, l in ROWS}: alpha[2,l]*t[i,2] + x[i,l] <= 1;
c8{i in 4..N_gates, l in ROWS}: alpha[1,l]*t[i,1] + alpha[2,l]*t[i,2] 
+ x[i,l] - s[i] >= 0;
c9{i in 1..3, l in ROWS}: alpha[1,l]*t[i,1] + alpha[2,l]*t[i,2] + x[2*i,l] 
+ x[2*i+1,l] + x[i,l] - s[i] >= 0;
c10{i in GATES, l in ROWS}: s[i] - x[i,l] >= 0;
c11: s[1] >= 1;
c12: x[1,1] = 0; 
c13: x[1,2] = 1;
c14: x[1,3] = 1;
c15: x[1,4] = 0;





