param n_v1;
param n_v2;

set v1:= 1..n_v1;
set v2:= 1..n_v2;

param blocks(v1,v2);
param prbl(v2);

var X{v2} binary; #1 if extracted 0 if not#



param A(i in v1, j in v2):=
	if(blocks[i,j]==1) then  x[j]-x[i]>=0;

maximize profit: sum{j in v2}prbl[j]*X{j};
