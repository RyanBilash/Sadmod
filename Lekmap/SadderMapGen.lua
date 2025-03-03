include("HBMapGenerator");

function GenerateMoreCoasts(args)
	print("Setting coasts and oceans but more coast (SadMapGenerator.Lua)");
	local args = args or {};
	local bExpandCoasts = args.bExpandCoasts or true;
	--local expansion_diceroll_table = args.expansion_diceroll_table or {100, 2};
    local loop_num = 40
    local inverse_odds_coast = 26
    print(inverse_odds_coast)
	
	local shallowWater = GameDefines.SHALLOW_WATER_TERRAIN;
	local deepWater = GameDefines.DEEP_WATER_TERRAIN;

	for i, plot in Plots() do
		if(plot:IsWater()) then
			if(plot:IsAdjacentToLand()) then
				plot:SetTerrainType(shallowWater, false, false);
			else
				plot:SetTerrainType(deepWater, false, false);
			end
		end
	end
	
	if bExpandCoasts == false then
		return
	end

	print("Expanding coasts ########################################################################################################################################## (MapGenerator.Lua)");
	--for loop, iExpansionDiceroll in ipairs(expansion_diceroll_table) do
    for loop=1,loop_num do
        --print(loop)
		local shallowWaterPlots = {};
		for i, plot in Plots() do
			if(plot:GetTerrainType() == deepWater) then
				-- Chance for each eligible plot to become an expansion is 1 / iExpansionDiceroll.
				-- Default is two passes at 1/4 chance per eligible plot on each pass.
				--if(plot:IsAdjacentToShallowWater() and Map.Rand(iExpansionDiceroll, "add shallows") == 0) then
                if(plot:IsAdjacentToShallowWater() and Map.Rand(inverse_odds_coast, "add shallows") == 0) then
					table.insert(shallowWaterPlots, plot);
				end
			end
		end
        --local num_expanded = 0
		for i, plot in ipairs(shallowWaterPlots) do
            --num_expanded = num_expanded + 1;
			plot:SetTerrainType(shallowWater, false, false);
		end
        --print(num_expanded);
	end
end
