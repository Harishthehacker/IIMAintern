#sets
set RETAILERS;
set REGIONS;
set GROUPS;

#parameters
param oil{RETAILERS};
param delivery_points{RETAILERS};
param spirit{RETAILERS};
param growth{RETAILERS} in GROUPS;
param region{RETAILERS} in REGIONS;

#variables
var x{RETAILERS} binary; # 1 if retailer is assigned to D1, 0 if assigned to D2
var y1 >= 0;
var y2 >= 0;
var z;

#constraints
subject to TotalDeliveryPoints: sum{i in RETAILERS} delivery_points[i] * x[i] + y1 - y2 = 0.4 * sum{i in RETAILERS} delivery_points[i];
subject to SpiritMarket: sum{i in RETAILERS} spirit[i] * x[i] + y1 - y2 = 0.4 * sum{i in RETAILERS} spirit[i];
subject to OilMarketRegion1: sum{i in RETAILERS: region[i] = 'Region 1'} oil[i] * x[i] + y1 - y2 = 0.4 * sum{i in RETAILERS: region[i] = 'Region 1'} oil[i];
subject to OilMarketRegion2: sum{i in RETAILERS: region[i] = 'Region 2'} oil[i] * x[i] + y1 - y2 = 0.4 * sum{i in RETAILERS: region[i] = 'Region 2'} oil[i];
subject to OilMarketRegion3: sum{i in RETAILERS: region[i] = 'Region 3'} oil[i] * x[i] + y1 - y2 = 0.4 * sum{i in RETAILERS: region[i] = 'Region 3'} oil[i];
subject to GroupA: sum{i in RETAILERS: growth[i]='A'} x[i] + y1 - y2 = 0.4 * sum{i in RETAILERS:growth [i]='A'};
subject to GroupB :sum {iinRETAILER S:growth [i]='B' }x [i]+y1-y2=0.4*sum {iinRETAILER S:growth [i]='B' };

subject to MinimaxConstraint1: z - (sum {iinRETAILER S}delivery_point s [i]*x [i]-0.4*sum {iinRETAILER S}delivery_point s [i])/sum {iinRETAILER S}delivery_point s [i]>=0;
subject to MinimaxConstraint2: z - (sum {iinRETAILER S}spirit [i]*x [i]-0.4*sum {iinRETAILER S}spirit [i])/sum {iinRETAILER S}spirit [i]>=0;
subject to MinimaxConstraint3: z - (sum {iinRETAILER S:region [i]='Region1' }oil [i]*x [i]-0.4*sum {iinRETAILER S:region [i]='Region1' }oil [i])/sum {iinRETAILER S:region [i]='Region1' }oil [i]>=0;
subject to MinimaxConstraint4: z - (sum { i in RETAILERS : region[i] = 'Region 2'} oil[i]*x[
