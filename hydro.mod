set time;
set gen;
set hydro;

param demand{time};
param hours{time};
param units{gen};
param min_kWh{gen};
param max_kWh{gen};
param starting_cost{gen};
param running_cost{gen};
param inc_cost{gen};
param SR;
param op_level {hydro};
param hydro_cost {hydro};
param depth_reduction {hydro};
param hydro_start_cost {hydro};
param min_depth;
param max_depth;
param midnight_depth;
param pump_cost;

var num_operate{gen, time} >=0 integer;
var output{gen, time} >=0;
var on{gen, time} >=0 integer;
var inc_output{gen, time} >=0;
var switch_cost >=0;
var run_cost >=0;
var hy {hydro, time} binary;#1 if hydro of type i working time t
var tm {hydro, time} binary;#1 if hydro started in time t
var l {time} >= 0;
var p {time} >= 0;

minimize total_cost:(switch_cost + run_cost);
subject to
constraint1: switch_cost = sum{g in gen, t in time} starting_cost[g]*on[g, t] + sum{h in hydro, t in time} hydro_start_cost[h] * tm[h,t]; 
constraint2: run_cost = sum{g in gen, t in time} (hours[t]*running_cost[g]*num_operate[g, t] + hours[t]*inc_cost[g]*inc_output[g, t]) + sum{h in hydro, t in time} (hours[t]*hydro_cost[h]*hy[h,t]);
constraint3 {t in time}: sum{g in gen} output[g, t] + sum {h in hydro} op_level[h] * hy[h,t] - p[t] >= demand[t];
constraint4 {g in gen, t in time}: output[g,t] >= min_kWh[g]*num_operate[g,t];
constraint5 {g in gen, t in time}: output[g,t] <= max_kWh[g]*num_operate[g,t];
constraint6 {t in time}: sum {g in gen} min_kWh[g]*num_operate[g,t] >= (demand[t]*(SR) - sum {h in hydro} op_level[h]);
constraint7 {g in gen, t in time: t>=2}: on[g,t] >= num_operate[g,t]-num_operate[g,t-1];
constraint7_1 {g in gen, t in time: t=1}: on[g,t] = num_operate[g,t];
constraint8 {h in hydro, t in time: t > 1}: tm[h,t] >= hy[h,t]-hy[h,t-1];
constraint9 {t in time: t}: min_depth <= l[t] <= max_depth;
#constraint10: l[1] = midnight_depth;
constraint11 {t in time: t > 1}: l[t] = l[t-1] + hours[t]/pump_cost * p[t] - sum {h in hydro} depth_reduction[h] * hy[h,t];





