
param n_level;
param n_v1;
param n_v2;

set v1:= 1..n_v1;
set v2:= 1..n_v2;
set levels:= 1..n_level;

param level_profit{levels};
param block_level{v2};
param blocks{v1,v2};
param ore_value{v2};
param R;

var X{v2} binary; #1 if extracted 0 if not#

maximize profit: sum{j in v2}((ore_value[j]*R)-(level_profit[block_level[j]]))*X[j];

subject to
Level_dependence{i in v1, j in v2: blocks[i,j]=1}: X[j]-X[i]>=0;
	

	
	
	
	