

/*
	This is a simple mission using precisely placed loot crates and infantry, static weapons and vehicle patrols.
	See the accompanying example mission in the exampleMission folder to get an idea how I laid this out.
	Note that I exported the mission using the exportAll function of M3EDEN editor.
*/

#include "privateVars.sqf";

_mission = "static mission template";  //  Included for additional documentation. Not intended to be spawned as a mission per se.

_difficulty = "red";  // Skill level of AI (blue, red, green etc)
diag_log format["[blckeagls static missions] STARTED initializing mission %1 difficulty %2",_mission,_difficulty];
_crateLoot = blck_BoxLoot_Orange;  // You can use a customized _crateLoot configuration by defining an array here. It must follow the following format shown for a hypothetical loot array called _customLootArray
	/*
	_customLootArray = 
		// Loot is grouped as [weapons],[magazines],[items] in order to be able to use the correct function to load the item into the crate later on.
		// Each item consist of the following information ["ItemName",minNum, maxNum] where min is the smallest number added and min+max is the largest number added.
		
		[  
			[// Weapons	

				["srifle_DMR_06_olive_F","20Rnd_762x51_Mag"]				
			],
			[//Magazines
				["10Rnd_93x64_DMR_05_Mag" ,1,5]				
			],			
			[  // Optics
				["optic_KHS_tan",1,3]
			],
			[// Materials and supplies				
				["Exile_Item_MetalScrews",3,10]
				//
			],
			[//Items
				["Exile_Item_MountainDupe",1,3]				
			],
			[ // Backpacks
				["B_OutdoorPack_tan",1,2]
			]
	];	
	*/

_lootCounts = blck_lootCountsOrange; // You can use a customized set of loot counts or one that is predefined but it must follow the following format:
								  // values are: number of things from the weapons, magazines, optics, materials(cinder etc), items (food etc) and backpacks arrays to add, respectively.
								  //  blck_lootCountsOrange = [[6,8],[24,32],[5,10],[25,35],16,1];   // Orange

/****************************************************

	PLACE MARKER DEFINITIONS PULLED FROM YOUR MISSION BELOW
	
*****************************************************/

_missionCenter = [16611.7,13686.6,0];
_markerType = ["mil_warning",[0,0]];
_markerColor = "ColorEAST";
_markerMissionName = "Rebel Base";
_markerLabel = "";

/****************************************************

	PLACE THE DATA DEFININING THE BUILDINGS, VEHICLES ETC. PULLED FROM YOUR MISSION BELOW
	
*****************************************************/
								  
_garrisonedBuildings_BuildingPosnSystem = [
];

_garrisonedBuilding_ASLsystem = [
     ["Land_Shed_Big_F",[16588.4,13488.5,7.87315],[[0.0638885,-0.997957,0],[0,0,1]],[true,true],"Red",[["B_HMG_01_high_F",[1.55273,1.18555,0.181307],93.2807]],[],0,0],
     ["Land_Cargo_HQ_V3_F",[16600.5,13566.4,10.0206],[[0.584069,-0.811704,0],[0,0,1]],[true,true],"Red",[["B_HMG_01_high_F",[3.69141,-1.25098,3.11677],0.004367]],[],0,0],
     ["Land_ContainerLine_02_F",[16626.2,13448,6.41892],[[0.71734,0.696723,0],[0,0,1]],[true,true],"Red",[["B_HMG_01_high_F",[-2.3125,-2.18945,2.6034],359.998]],[],0,0],
     ["Land_ContainerLine_02_F",[16635.5,13478.6,7.08653],[[0.69244,-0.721476,0],[0,0,1]],[true,true],"Red",[["B_HMG_01_high_F",[-0.720703,3.36035,2.60349],123.167]],[],0,0],
     ["Land_ContainerLine_03_F",[16657.7,13444,5.62811],[[-0.74433,0.667813,0],[0,0,1]],[true,true],"Red",[["B_HMG_01_high_F",[-2.28711,-2.87109,2.60363],360]],[],0,0],
     ["Land_Cargo_HQ_V3_F",[16680.5,13698.6,5.80111],[[-0.940233,-0.340533,0],[0,0,1]],[true,true],"Red",[["B_HMG_01_high_F",[-1.56055,-3.20215,3.11507],0.00377411]],[],0,0],
     ["Land_Cargo_HQ_V3_F",[16694.7,13491.3,10.0104],[[0.780344,-0.62535,0],[0,0,1]],[true,true],"Red",[["B_HMG_01_high_F",[-2.77734,4.33984,3.11147],359.946]],[],0,0],
     ["Land_Cargo_HQ_V3_F",[16769.4,13595.1,9.78175],[[0.613346,0.789814,0],[0,0,1]],[true,true],"Red",[["B_HMG_01_high_F",[7.5918,0.638672,3.0864],119.373]],[],0,0]
];

_missionLandscape = [
     ["Land_PowerPoleWooden_L_F",[16541.5,13629.2,4.17884],[[-0.995768,-0.0918992,0],[0,0,1]],[true,true]],
     ["Land_LightHouse_F",[16545.5,13633.6,4.4652],[[0.7981,-0.602526,0],[0,0,1]],[true,true]],
     ["Land_TBox_F",[16541.2,13626,4.44433],[[-0.998656,-0.051829,0],[0,0,1]],[true,true]],
     ["Land_ReservoirTank_V1_F",[16619.7,13550.6,11.6588],[[0.588807,-0.808273,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16618.5,13566,12.5747],[[0.636874,-0.770968,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16618.1,13562.9,12.2202],[[0.814044,0.580803,0],[0,0,1]],[true,true]],
     ["Land_Crane_F",[16643.4,13477,7.02917],[[-0.678927,0.734206,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16627.2,13550.5,12.1013],[[0.777176,0.629283,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16621,13558.6,12.536],[[0.83718,0.546928,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16624,13554.5,12.2898],[[0.78487,0.61966,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16630.5,13546.5,11.8742],[[0.744806,0.667282,0],[0,0,1]],[true,true]],
     ["Land_ReservoirTank_V1_F",[16624.8,13542,10.9256],[[0.5868,-0.809732,0],[0,0,1]],[true,true]],
     ["Land_dp_smallTank_F",[16638.9,13575.4,13.4574],[[0.852596,0.52257,0],[0,0,1]],[true,true]],
     ["Land_dp_smallTank_F",[16648.3,13581.1,13.4204],[[0.782466,0.622693,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16634.3,13579.3,12.5202],[[0.656915,-0.753965,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16622.5,13569.3,12.5919],[[0.635385,-0.772195,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16638.1,13582.6,12.4031],[[0.650338,-0.759645,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16630.3,13575.9,12.9117],[[0.638951,-0.769248,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16626.5,13572.6,12.7383],[[0.644988,-0.764193,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16641.9,13585.9,12.2587],[[0.634561,-0.772873,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16645.9,13589.2,12.5642],[[0.639949,-0.768418,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16649.8,13592.4,11.8126],[[0.621527,-0.783393,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16662.8,13516.5,11.2794],[[-0.0801478,0.996783,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16677,13521,11.4599],[[-0.695975,0.718066,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16658.5,13517.9,11.018],[[0.601142,0.799142,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16672.8,13518.6,11.2618],[[-0.318363,0.947969,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16654.3,13520.9,11.2419],[[0.566026,0.824387,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16667.9,13517.4,11.1257],[[-0.205196,0.978721,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16650.1,13523.9,11.4834],[[0.569665,0.821877,0],[0,0,1]],[true,true]],
     ["Land_Factory_Main_F",[16676.9,13581.9,14.2215],[[-0.671008,0.74145,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16675.6,13604.3,13.614],[[-0.805857,-0.592111,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16661.6,13602.3,12.3802],[[0.634067,-0.773278,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16672.5,13608.5,13.1606],[[-0.787133,-0.616783,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16657.7,13599,12.1086],[[0.653438,-0.75698,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16665.5,13605.5,12.5239],[[0.626326,-0.779561,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16653.8,13595.6,11.9817],[[0.640364,-0.768071,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16669.5,13608.7,12.8265],[[0.614596,-0.788842,0],[0,0,1]],[true,true]],
     ["Land_Airport_Tower_F",[16692.5,13445.7,5.9012],[[0.778493,0.627653,0],[0,0,1]],[true,true]],
     ["Land_Wreck_BRDM2_F",[16693,13522.8,10.5827],[[-0.807166,0.581163,0.103598],[0.111303,-0.0225192,0.993531]],[true,true]],
     ["Land_Wreck_AFV_Wheeled_01_F",[16699.9,13528.9,10.5831],[[-0.778789,0.626165,0.0374727],[0.0266571,-0.0266476,0.999289]],[true,true]],
     ["Land_CncWall4_F",[16684.2,13528.4,11.1379],[[-0.728322,0.685235,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16680.7,13524.6,11.5518],[[-0.722957,0.690893,0],[0,0,1]],[true,true]],
     ["Land_i_Barracks_V2_F",[16681.6,13542.2,11.1399],[[-0.722774,0.691085,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16698.1,13549.6,10.5868],[[-0.885219,0.465174,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16699.2,13554.3,10.4971],[[-0.999715,-0.0238563,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16695.8,13545,10.7723],[[-0.886638,0.462464,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16699.2,13559.3,11.0638],[[-1,0.000239384,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16693.3,13540.5,10.8451],[[-0.88375,0.467959,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16690.8,13535.9,10.8922],[[-0.867583,0.497293,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16687.8,13532,11.2186],[[-0.709586,0.704619,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16699.3,13569.8,11.8292],[[-0.99977,0.0214389,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16699.7,13574.9,12.3665],[[-0.996419,0.0845509,0],[0,0,1]],[true,true]],
     ["Land_CncWall4_F",[16699.3,13564.5,11.4698],[[-0.999499,-0.0316629,0],[0,0,1]],[true,true]],
     ["Land_TTowerBig_2_F",[16701.4,13598.2,14.0333],[[0.612916,-0.790148,0],[0,0,1]],[true,true]],
     ["Land_Timbers_F",[16709.6,13595.6,13.5401],[[0.729271,0.683881,-0.0217062],[0.0559122,-0.0279456,0.998044]],[true,true]],
     ["Land_Timbers_F",[16709.2,13606.3,13.7399],[[0.695414,0.71783,-0.0334676],[0.0439577,0.00399288,0.999025]],[true,true]],
     ["Land_Timbers_F",[16699.8,13608.3,14.0608],[[0.767648,0.640757,-0.0121148],[0.0146639,0.00133707,0.999892]],[true,true]],
     ["Land_Cargo_Tower_V3_F",[16738,13579.1,10.2867],[[-0.724138,-0.689655,0],[0,0,1]],[true,true]],
     ["Land_Timbers_F",[16718,13586.3,12.0888],[[0.739738,0.672811,0.010633],[0.088979,-0.113469,0.989549]],[true,true]],
     ["Land_Cargo_House_V3_F",[16733.7,13615.3,11.0239],[[-0.668012,-0.74415,0],[0,0,1]],[true,true]],
     ["Land_Cargo_House_V3_F",[16739.5,13610.1,10.7494],[[-0.641751,-0.766913,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16725.3,13611.7,12.2274],[[0.666164,0.745806,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16719.5,13616.8,13.0459],[[0.689169,0.724601,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16716.8,13619.5,13.4303],[[0.722213,0.691671,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16722.4,13614.3,12.624],[[0.648536,0.761184,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16728.1,13609.1,11.8479],[[0.654713,0.755878,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16731.1,13606.6,11.4517],[[0.626877,0.779118,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16734.1,13604.3,11.1686],[[0.588696,0.808355,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16737.2,13601.9,11.0268],[[0.639483,0.768805,0],[0,0,1]],[true,true]],
     ["Land_Timbers_F",[16720.4,13596,12.4045],[[0.710779,0.701664,-0.049608],[0.100817,-0.0318219,0.994396]],[true,true]],
     ["Land_Timbers_F",[16710.8,13616.8,13.589],[[-0.787112,-0.611524,0.0805739],[0.0916127,0.0132756,0.995706]],[true,true]],
     ["Land_Timbers_F",[16731.7,13597,11.4529],[[0.687225,0.725611,-0.0347806],[0.0771031,-0.0252494,0.996703]],[true,true]],
     ["Land_Timbers_F",[16719.6,13606.4,12.5235],[[0.779093,0.626861,0.00764272],[0.0426276,-0.0651347,0.996966]],[true,true]],
     ["Land_Cargo_House_V3_F",[16739.4,13633.7,10.5359],[[0.659689,0.751539,0],[0,0,1]],[true,true]],
     ["Land_Cargo_House_V3_F",[16722.2,13626.2,12.788],[[-0.695876,-0.718162,0],[0,0,1]],[true,true]],
     ["Land_Cargo_House_V3_F",[16727.7,13620.9,11.9954],[[-0.674468,-0.738304,0],[0,0,1]],[true,true]],
     ["Land_Cargo_House_V3_F",[16734.3,13638.2,10.7238],[[0.677591,0.735439,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16722.6,13633,12.2495],[[0.71744,-0.69662,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16739.3,13641.3,9.93247],[[-0.665245,-0.746625,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16731.5,13641,10.7501],[[0.718739,-0.69528,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16736.5,13644,9.98324],[[-0.702085,-0.712093,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16734.1,13643.8,10.2268],[[0.719557,-0.694433,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16719.9,13630.2,12.8032],[[0.706519,-0.707695,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16717.2,13627.5,13.4239],[[0.714166,-0.699976,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16728.8,13638.3,11.2981],[[0.714979,-0.699146,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16714.4,13624.8,13.9102],[[0.641997,-0.766707,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16714.2,13622.4,13.81],[[0.749739,0.661734,0],[0,0,1]],[true,true]],
     ["Land_BagBunker_Tower_F",[16759.4,13552.8,9.39595],[[-0.037293,-0.999304,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16751.8,13589.4,11.042],[[0.622344,0.782744,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16755.2,13588.3,11.0032],[[0,1,0],[0,0,1]],[true,true]],
     ["Land_Cargo_House_V3_F",[16759.1,13617.3,9.62409],[[0.634349,0.773047,0],[0,0,1]],[true,true]],
     ["Land_Cargo_House_V3_F",[16745.7,13604.9,10.4605],[[-0.614691,-0.788768,0],[0,0,1]],[true,true]],
     ["Land_Cargo_House_V3_F",[16752.7,13598.5,10.7154],[[-0.640043,-0.768339,0],[0,0,1]],[true,true]],
     ["Land_Cargo_House_V3_F",[16765.1,13612.4,9.21962],[[0.606722,0.794914,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16748.8,13591.9,11.0085],[[0.613459,0.789726,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16743,13596.9,10.9734],[[0.614587,0.788849,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16768.6,13616.5,8.98599],[[-0.624073,-0.781366,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16740.1,13599.4,10.9046],[[0.646529,0.762889,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16745.9,13594.4,10.9746],[[0.659979,0.751284,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16765.6,13618.9,9.28138],[[-0.612479,-0.790487,0],[0,0,1]],[true,true]],
     ["Land_Cargo_House_V3_F",[16745.4,13628.5,9.82596],[[0.657767,0.753222,0],[0,0,1]],[true,true]],
     ["Land_Cargo_House_V3_F",[16752.4,13622.6,9.66163],[[0.643267,0.765642,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16750.8,13631.1,9.37541],[[-0.677325,-0.735684,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16756.6,13626.1,9.37731],[[-0.637536,-0.770421,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16748,13633.7,9.38367],[[-0.669083,-0.743187,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16759.5,13623.6,9.40288],[[-0.635297,-0.772268,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16745.1,13636.2,9.58846],[[-0.676424,-0.736512,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16753.7,13628.5,9.3666],[[-0.649415,-0.760434,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16742.2,13638.8,9.7736],[[-0.651003,-0.759075,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16762.5,13621.2,9.42662],[[-0.622407,-0.782694,0],[0,0,1]],[true,true]],
     ["Land_Research_house_V1_F",[16767.2,13636.5,9.85013],[[0.743525,-0.668708,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16771.6,13614.1,8.78738],[[-0.618148,-0.786061,0],[0,0,1]],[true,true]],
     ["Land_Mil_WallBig_4m_F",[16773.1,13611.1,8.69503],[[-0.991471,-0.130325,0],[0,0,1]],[true,true]],
     ["Land_Research_house_V1_F",[16772.7,13641.9,10.0521],[[0.754721,-0.656046,0],[0,0,1]],[true,true]],
     ["Land_Research_house_V1_F",[16778.6,13647.5,10.2659],[[0.733823,-0.67934,0],[0,0,1]],[true,true]],
     ["Land_Research_house_V1_F",[16783.8,13652.9,10.418],[[0.730432,-0.682985,0],[0,0,1]],[true,true]],
     ["Land_spp_Panel_F",[16798.5,13696.2,5.44495],[[-0.0215388,0.999768,0],[0,0,1]],[true,true]],
     ["Land_spp_Panel_F",[16778,13702.7,5.73989],[[0,1,0],[0,0,1]],[true,true]],
     ["Land_wpp_Turbine_V2_F",[16795.5,13714,4.40283],[[0,1,0],[0,0,1]],[true,true]],
     ["Land_BagBunker_Small_F",[16818.3,13553.8,2.74672],[[-0.914506,0.396985,0.0779867],[0.0757814,-0.0212658,0.996898]],[true,true]],
     ["Land_BarGate_F",[16824.8,13558.3,2.5635],[[0.66388,-0.74784,0],[0,0,1]],[true,true]],
     ["Land_BagBunker_Small_F",[16828.9,13564.3,2.36731],[[-0.648363,0.757195,0.0792529],[0.115228,-0.00530196,0.993325]],[true,true]],
     ["Land_spp_Panel_F",[16827.1,13677,6.91303],[[0,1,0],[0,0,1]],[true,true]],
     ["Land_spp_Panel_F",[16816.4,13683.1,7.76673],[[0,1,0],[0,0,1]],[true,true]],
     ["Land_wpp_Turbine_V2_F",[16827.5,13695.8,5.13451],[[0,1,0],[0,0,1]],[true,true]],
     ["Land_wpp_Turbine_V2_F",[16850.9,13638.8,4.72087],[[0,1,0],[0,0,1]],[true,true]],
     ["Land_spp_Panel_F",[16835.2,13662.8,6.34266],[[0,1,0],[0,0,1]],[true,true]],
     ["Land_wpp_Turbine_V2_F",[16848.8,13670.7,3.94425],[[0,1,0],[0,0,1]],[true,true]]
];

_aiGroupParameterChoices = [
     [[16583.5,13619.6,6.22159],"Red",[3,6],45,0,0],
     [[16588.5,13614.8,6.48222],"Red",[3,6],45,0,0],
     [[16584.3,13619.4,6.22461],"Red",[3,6],45,0,0],
     [[16589.8,13614.4,6.49919],"Red",[3,6],45,0,0],
     [[16574,13642.1,3.34919],"Red",[3,6],45,0,0],
     [[16578.7,13637.6,4.08276],"Red",[3,6],45,0,0],
     [[16575.7,13636.2,4.18464],"Red",[3,6],45,0,0],
     [[16580.7,13631.6,5.12038],"Red",[3,6],45,0,0],
     [[16576.2,13630.5,5.0617],"Red",[3,6],45,0,0],
     [[16574.7,13625.4,5.59371],"Red",[3,6],45,0,0],
     [[16579.8,13620.8,6.10737],"Red",[3,6],45,0,0],
     [[16581.9,13636.4,4.30079],"Red",[3,6],45,0,0],
     [[16586.4,13631.7,5.07396],"Red",[3,6],45,0,0],
     [[16584.4,13630.4,5.34856],"Red",[3,6],45,0,0],
     [[16584.1,13624.8,6.02005],"Red",[3,6],45,0,0],
     [[16574,13642.1,3.34919],"Red",[3,6],45,0,0],
     [[16579,13637.6,4.09041],"Red",[3,6],45,0,0],
     [[16576.5,13636,4.22807],"Red",[3,6],45,0,0],
     [[16581.8,13631.1,5.24011],"Red",[3,6],45,0,0],
     [[16575.4,13630.3,5.02557],"Red",[3,6],45,0,0],
     [[16575.6,13625.2,5.6337],"Red",[3,6],45,0,0],
     [[16581.1,13621.2,6.07646],"Red",[3,6],45,0,0],
     [[16581.9,13636.4,4.30079],"Red",[3,6],45,0,0],
     [[16586.9,13631.9,5.05677],"Red",[3,6],45,0,0],
     [[16584.4,13630.4,5.34856],"Red",[3,6],45,0,0],
     [[16589.2,13626.1,5.83722],"Red",[3,6],45,0,0],
     [[16584.6,13625.5,5.9896],"Red",[3,6],45,0,0],
     [[16589.7,13625.8,5.83631],"Red",[3,6],45,0,0],
     [[16601.2,13616.1,6.12403],"Red",[3,6],45,0,0],
     [[16598.8,13614.5,6.30149],"Red",[3,6],45,0,0],
     [[16603.7,13610.1,6.45223],"Red",[3,6],45,0,0],
     [[16598.5,13608.9,6.63824],"Red",[3,6],45,0,0],
     [[16597.8,13603.7,6.9763],"Red",[3,6],45,0,0],
     [[16602.7,13599.2,7.83527],"Red",[3,6],45,0,0],
     [[16596.3,13620.6,6.06806],"Red",[3,6],45,0,0],
     [[16645.8,13535,10.5802],"Red",[3,6],45,0,0],
     [[16644.3,13551.8,12.9042],"Red",[3,6],45,0,0],
     [[16649.2,13547.4,12.653],"Red",[3,6],45,0,0],
     [[16646.8,13545.8,12.4119],"Red",[3,6],45,0,0],
     [[16646.5,13540.2,11.3865],"Red",[3,6],45,0,0],
     [[16627.4,13616.8,8.71084],"Red",[3,6],45,0,0],
     [[16620.9,13638.2,5.30318],"Red",[3,6],45,0,0],
     [[16625.8,13633.7,6.27879],"Red",[3,6],45,0,0],
     [[16623.4,13632.1,6.46093],"Red",[3,6],45,0,0],
     [[16628.3,13627.7,8.21681],"Red",[3,6],45,0,0],
     [[16623.1,13626.5,7.07365],"Red",[3,6],45,0,0],
     [[16622.4,13621.3,7.01222],"Red",[3,6],45,0,0],
     [[16658,13527.4,11.2917],"Red",[3,6],45,0,0],
     [[16652.7,13555.7,13.2948],"Red",[3,6],45,0,0],
     [[16657.6,13551.2,12.9973],"Red",[3,6],45,0,0],
     [[16654.2,13549.6,12.8484],"Red",[3,6],45,0,0],
     [[16659.1,13544.9,12.2902],"Red",[3,6],45,0,0],
     [[16651.7,13541.3,11.906],"Red",[3,6],45,0,0],
     [[16659.7,13542.3,12.0008],"Red",[3,6],45,0,0],
     [[16664.7,13537.8,11.386],"Red",[3,6],45,0,0],
     [[16651.4,13535.7,11.1565],"Red",[3,6],45,0,0],
     [[16659.8,13535.9,11.4279],"Red",[3,6],45,0,0],
     [[16664.8,13531.4,10.8786],"Red",[3,6],45,0,0],
     [[16653.1,13531.9,11.2337],"Red",[3,6],45,0,0],
     [[16650.7,13530.5,11.1174],"Red",[3,6],45,0,0],
     [[16678.1,13648.6,11.2494],"Red",[3,6],45,0,0],
     [[16676.5,13665.5,8.52921],"Red",[3,6],45,0,0],
     [[16679.1,13659.4,9.88843],"Red",[3,6],45,0,0],
     [[16678.7,13653.9,10.7595],"Red",[3,6],45,0,0],
     [[16685.2,13619.1,13.3112],"Red",[3,6],45,0,0],
     [[16690.1,13614.6,13.8307],"Red",[3,6],45,0,0],
     [[16683.7,13636,12.3255],"Red",[3,6],45,0,0],
     [[16688.6,13631.5,12.7752],"Red",[3,6],45,0,0],
     [[16686.2,13629.9,12.5943],"Red",[3,6],45,0,0],
     [[16691.1,13625.4,13.1721],"Red",[3,6],45,0,0],
     [[16685.8,13624.3,12.9095],"Red",[3,6],45,0,0],
     [[16702,13646.2,12.1324],"Red",[3,6],45,0,0],
     [[16699.6,13644.6,12.3381],"Red",[3,6],45,0,0],
     [[16704.6,13640.1,12.8613],"Red",[3,6],45,0,0],
     [[16699.3,13639,13.017],"Red",[3,6],45,0,0],
     [[16698.7,13633.8,13.32],"Red",[3,6],45,0,0],
     [[16703.6,13629.3,13.8694],"Red",[3,6],45,0,0],
     [[16683,13644.2,11.959],"Red",[3,6],45,0,0],
     [[16697.1,13650.6,11.628],"Red",[3,6],45,0,0],
     [[16681.5,13661,9.90377],"Red",[3,6],45,0,0],
     [[16684,13655,10.9516],"Red",[3,6],45,0,0],
     [[16789.2,13644.5,10.4788],"Red",[3,6],45,0,0],
     [[16794.1,13640,10.4839],"Red",[3,6],45,0,0],
     [[16791.7,13638.4,10.4392],"Red",[3,6],45,0,0],
     [[16796.6,13633.9,10.4148],"Red",[3,6],45,0,0],
     [[16791.4,13632.9,10.3295],"Red",[3,6],45,0,0],
     [[16790.7,13627.6,10.2041],"Red",[3,6],45,0,0],
     [[16795.7,13623.2,10.0404],"Red",[3,6],45,0,0],
     [[16797.1,13638.8,10.482],"Red",[3,6],45,0,0],
     [[16799.6,13632.8,10.4115],"Red",[3,6],45,0,0],
     [[16799.3,13627.2,10.3968],"Red",[3,6],45,0,0],
     [[16798.6,13622,10.0542],"Red",[3,6],45,0,0],
     [[16803.6,13617.4,9.5929],"Red",[3,6],45,0,0],
     [[16802,13634.2,10.4692],"Red",[3,6],45,0,0],
     [[16804.5,13628.3,10.5612],"Red",[3,6],45,0,0]
];
_aiGroupParameters = [];
for "_i" from 1 to 15 do
{
     _aiGroupParameterChoices call BIS_fnc_arrayShuffle;
     _g = _aiGroupParameterChoices deleteAt 0;
     if !(_g isEqualTo []) then
     {
          _aiGroupParameters pushBack _g;
     };
};
_aiScubaGroupParameters = [
];

_vehiclePatrolParameters = [
     ["B_MRAP_01_hmg_F",[16620.7,13589.5,10.5163],"Red",75,0,0],
     ["B_APC_Wheeled_01_cannon_F",[16650.5,13621.2,10.5844],"Red",75,0,0],
     ["B_MRAP_01_hmg_F",[16709,13504.3,9.73925],"Red",75,0,0],
     ["B_APC_Wheeled_01_cannon_F",[16772.4,13564.2,8.21384],"Red",75,0,0],
     ["B_Boat_Armed_01_minigun_F",[16503,13464.5,-0.913055],"Red",75,0,0],
     ["B_Boat_Armed_01_minigun_F",[16630.6,13754.2,-0.932493],"Red",75,0,0],
     ["B_Boat_Armed_01_minigun_F",[16713.7,13366.1,-0.898195],"Red",75,0,0],
     ["B_Boat_Armed_01_minigun_F",[16845.6,13755.9,-0.893623],"Red",75,0,0]
];

_airPatrols = [
    // ["B_Heli_Transport_01_F",[16588.9,13530.1,8.70556],"Red",1700,0,0],
    // ["B_Heli_Transport_01_F",[16733.2,13674.8,9.12466],"Red",1700,0,,0]
];

_missionEmplacedWeapons = [
     ["B_HMG_01_high_F",[16671.5,13564.9,13.3844],"Red",0,0,0],
     ["B_HMG_01_high_F",[16656.9,13577.2,14.0205],"Red",0,0,0],
     ["B_HMG_01_high_F",[16682.4,13569.1,23.2697],"Red",0,0,0],
     ["B_HMG_01_high_F",[16734,13543.2,10.4471],"Red",0,0,0],
     ["B_HMG_01_high_F",[16717.7,13571,11.2289],"Red",0,0,0],
     ["B_HMG_01_high_F",[16727.4,13631,11.8628],"Red",0,0,0]
];

_submarinePatrolParameters = [
];

_missionLootBoxes = [
];

					  
								  
/****************************************************

	ENABLE ANY SETTINGS YOU LIKE FROM THE LIST BELOW. 
	iF THESE ARE NOT ENABLED THEN THE DEFAULTS DEFINED IN BLCK_CONFIG.SQF 
	AND THE MOD-SPECIFIC CONFIGURATIONS WILL BE USED.
	
*****************************************************/								  
			
/*			
_missionLandscapeMode = "precise"; // acceptable values are "random","precise"
									// In precise mode objects will be spawned at the relative positions specified.
									// In the random mode, objects will be randomly spawned within the mission area.

_aircraftTypes = blck_patrolHelisRed;  //  You can use one of the pre-defined lists in blck_configs or your own custom array.
_noAirPatrols =	blck_noPatrolHelisRed; // You can use one of the pre-defined values or a custom one. acceptable values are integers (1,2,3) or a range such as [2,4]; 
										//  Note: this value is ignored if you specify air patrols in the array below.
//  Change _useMines to true/false below to enable mission-specific settings.
_useMines  = blck_useMines;  // Set to false if you have vehicles patrolling nearby.
_uniforms  = blck_SkinList;  // You can replace this list with a custom list of uniforms if you like.
_headgear  = blck_headgear;  // You can replace this list with a custom list of headgear.
_vests     = blck_vests;     // You can replace this list with a custom list of vests.
_backpacks = blck_backpacks; // You can replace this list with a custom list of backpacks.
_weapons   = blck_WeaponList_Orange; // You can replace this list with a customized list of weapons, or another predifined list from blck_configs_epoch or blck_configs_exile as appropriate.
_sideArms  = blck_pistols;    // You can replace this list with a custom list of sidearms.
*/


//********************************************************
// Do not modify anything below this line.
//********************************************************
#include "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_initializeMission.sqf"; 

diag_log format["[blckeagls static missions] COMPLETED initializing middions %1 position at %2 difficulty %3",_mission,_missionCenter,_difficulty];