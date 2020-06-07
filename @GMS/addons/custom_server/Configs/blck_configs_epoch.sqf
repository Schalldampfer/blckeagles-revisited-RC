/*
	By Ghostrider [GRG]
	Copyright 2016

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/

#include "\q\addons\custom_server\Configs\blck_defines.hpp";
#include "\q\addons\custom_server\init\build.sqf";
diag_log format["[blckeagls] loading configurations for Epoch for blckeagls build %1",blck_buildNumber];
////////////
// Epoch-specific settings
////////////

	// list of locations that are protected against mission spawns

	switch (toLower(worldName)) do
	{
		case "altis": {
			blck_locationBlackList append [
			//Add location as [[xpos,ypos,0],minimumDistance],
			// Note that there should not be a comma after the last item in this table
			[[10800,10641,0],1000]  // isthmus - missions that spawn here often are glitched.
			];
		};
		case "tanoa": {
			blck_locationBlackList append [	];
		};
		case "malden": {
			blck_locationBlackList append [
				[[7980,6470,0],500],
				[[5550,7880,0],500]
			];
		};
	};

/*********************************************************************************

AI WEAPONS, UNIFORMS, VESTS AND GEAR

**********************************************************************************/

	blck_AI_Side = RESISTANCE;

	blck_crateMoneyBlue = [100,250];
	blck_crateMoneyRed = [175, 300];
	blck_crateMoneyGreen = [300, 500];
	blck_crateMoneyOrange = [500, 750];

	blck_allowSalesAtBlackMktTraders = true; // Allow vehicles to be sold at Halvjes black market traders.

	blck_maximumItemPriceInAI_Loadouts = 50;

	blck_lightlyArmed_ARMA3 = [
		"B_G_Offroad_01_armed_F", 
		"O_G_Offroad_01_armed_F",
		"B_MRAP_01_gmg_F", 
		"B_MRAP_01_hmg_F",
		"O_MRAP_02_gmg_F",  
		"O_MRAP_02_hmg_F",
		"I_MRAP_03_hmg_F", 
		"I_MRAP_03_gmg_F",
		"B_APC_Wheeled_01_cannon_F", 
		"I_APC_Wheeled_03_cannon_F"
	];

	blck_tracked_APC_ARMA3 = [
		"B_APC_Tracked_01_rcws_F",
		"B_APC_Tracked_01_CRV_F",
		"B_APC_Tracked_01_AA_F",
		"O_APC_Tracked_02_cannon_F", 
		"O_APC_Tracked_02_AA_F",
		"O_APC_Wheeled_02_rcws_F", 
		"I_APC_tracked_03_cannon_F"
	];

	blck_Tanks_ARMA3 = [
		//"B_MBT_01_arty_F",
		"B_MBT_01_mlrs_F",
		"B_MBT_01_TUSK_F",
		"O_MBT_02_cannon_F",
		//"O_MBT_02_arty_F",
		"I_MBT_03_cannon_F"
	];

	blck_APC_CUP = [
		"CUP_B_Mastiff_GMG_GB_D",  
		"CUP_B_Mastiff_HMG_GB_D",  
		"CUP_B_Ridgback_HMG_GB_D",  
		"CUP_B_Ridgback_GMG_GB_D",  
		"CUP_B_M1128_MGS_Desert",  
		"CUP_B_M1135_ATGMV_Desert_Slat",  
		"CUP_B_M1133_MEV_Desert_Slat",  
		"CUP_B_LAV25M240_desert_USMC",  
		"CUP_B_M1129_MC_MK19_Desert_Slat",  
		"CUP_B_LAV25_HQ_desert_USMC",  
		"CUP_B_BRDM2_ATGM_CDF",  
		"CUP_B_BTR60_CDF",  
		"CUP_B_M1130_CV_M2_Desert_Slat",  
		"CUP_B_M1126_ICV_MK19_Desert_Slat",  
		"CUP_O_BTR90_RU",  
		"CUP_O_GAZ_Vodnik_BPPU_RU",
		"CUP_B_M1126_ICV_M2_Desert",  
		"CUP_B_M1126_ICV_MK19_Desert",  
		"CUP_B_M1130_CV_M2_Desert",  
		"CUP_B_M1126_ICV_M2_Desert_Slat",  
		"CUP_B_M1133_MEV_Desert",  
		"CUP_O_GAZ_Vodnik_AGS_RU",  
		"CUP_O_GAZ_Vodnik_PK_RU"
	];

	blck_Tanks_CUP = [
		"CUP_B_M2A3Bradley_USA_D",  
		"CUP_B_M113_desert_USA",  
		"CUP_B_M163_USA",  
		"CUP_B_M6LineBacker_USA_D",  
		"CUP_B_M1A1_DES_US_Army",  
		"CUP_B_M1A2_TUSK_MG_DES_US_Army",  
		"CUP_B_AAV_USMC",  
		"CUP_B_M270_DPICM_USA",  
		"CUP_B_ZSU23_CDF",  
		"CUP_B_BMP2_CDF",  
		"CUP_B_T72_CDF",  
		"CUP_I_T34_NAPA",  
		"CUP_B_Challenger2_NATO",  
		"CUP_B_FV432_Bulldog_GB_D_RWS",  
		"CUP_B_FV432_Bulldog_GB_D",  
		"CUP_B_FV510_GB_D_SLAT",  
		"CUP_B_MCV80_GB_D_SLAT",  
		"CUP_O_2S6_RU",  
		"CUP_O_BMP3_RU",  
		"CUP_O_T90_RU",  
		"CUP_O_T55_SLA",  
		"CUP_O_BMP1P_TKA",  
		"CUP_B_M270_DPICM_USA",
		"CUP_B_M2Bradley_USA_W",  
		"CUP_B_FV510_GB_D",  
		"CUP_B_MCV80_GB_D",  
		"CUP_B_M7Bradley_USA_D",  
		"CUP_O_2S6_RU",  
		"CUP_O_BMP1_TKA"
	];

	blck_AIPatrolVehicles = ["B_G_Offroad_01_armed_EPOCH","B_LSV_01_armed_F","I_C_Offroad_02_LMG_F","B_T_LSV_01_armed_black_F","B_T_LSV_01_armed_olive_F","B_T_LSV_01_armed_sand_F"]; // Type of vehicle spawned to defend AI bases
	blck_AIPatrolVehiclesBlue = ["CUP_O_Datsun_PK","CUP_O_Datsun_PK_Random","CUP_O_Hilux_DSHKM_TK_INS","CUP_O_Hilux_M2_TK_INS","CUP_B_LR_MG_GB_W","CUP_O_LR_MG_TKM","CUP_O_UAZ_MG_RU","CUP_O_UAZ_MG_CSAT"];
	blck_AIPatrolVehiclesRed = ["CUP_O_Hilux_DSHKM_TK_INS","CUP_O_Hilux_M2_TK_INS","CUP_B_LR_MG_GB_W","CUP_O_LR_MG_TKM","CUP_B_HMMWV_M2_USMC","CUP_B_HMMWV_M1114_USMC","CUP_O_UAZ_AGS30_RU","CUP_O_UAZ_AGS30_CSAT","CUP_O_UAZ_MG_RU","CUP_O_UAZ_MG_CSAT"];
	blck_AIPatrolVehiclesGreen = ["CUP_O_Hilux_armored_M2_TK_INS","CUP_O_Hilux_armored_DSHKM_TK_INS","CUP_B_HMMWV_M2_USMC","CUP_B_M1165_GMV_USMC","CUP_O_UAZ_AGS30_RU","CUP_O_UAZ_AGS30_CSAT"];
	blck_AIPatrolVehiclesOrange = ["CUP_B_M1151_Deploy_WDL_USA","CUP_B_M1151_M2_WDL_USA","CUP_O_Hilux_btr60_TK_INS"];

	// Blacklisted itesm
	blck_blacklistedOptics = ["optic_Nightstalker","optic_tws","optic_tws_mg","optic_DMS","optic_DMS_ghex_F","optic_SOS","optic_SOS_khk_F","optic_LRPS","optic_LRPS_tna_F","optic_LRPS_ghex_F","CUP_optic_CWS","CUP_optic_AN_PVS_4","CUP_optic_AN_PVS_4_M14","CUP_optic_AN_PVS_4_M16","CUP_optic_AN_PVS_10","CUP_optic_AN_PVS_10_black","CUP_optic_AN_PVS_10_od","CUP_optic_AN_PAS_13c1","CUP_optic_AN_PAS_13c2","CUP_optic_NSPU","CUP_optic_GOSHAWK","CUP_optic_GOSHAWK_RIS","CUP_optic_NSPU_RPG","CUP_optic_LeupoldMk4_25x50_LRT","CUP_optic_LeupoldMk4_25x50_LRT_pip","CUP_optic_LeupoldMk4_25x50_LRT_DESERT","CUP_optic_LeupoldMk4_25x50_LRT_DESERT_pip","CUP_optic_LeupoldMk4_25x50_LRT_SNOW","CUP_optic_LeupoldMk4_25x50_LRT_SNOW_pip","CUP_optic_LeupoldMk4_25x50_LRT_WOODLAND","CUP_optic_LeupoldMk4_25x50_LRT_WOODLAND_pip","CUP_optic_LeupoldM3LR","CUP_optic_LeupoldM3LR_pip","CUP_optic_LeupoldMk4_20x40_LRT","CUP_optic_LeupoldMk4_20x40_LRT_pip","CUP_optic_LeupoldMk4_10x40_LRT_Desert","CUP_optic_LeupoldMk4_10x40_LRT_Desert_pip","CUP_optic_LeupoldMk4_10x40_LRT_Woodland","CUP_optic_LeupoldMk4_10x40_LRT_Woodland_pip","CUP_optic_LeupoldMk4_CQ_T","CUP_optic_LeupoldMk4_MRT_tan","CUP_optic_LeupoldMk4_MRT_tan_pip","CUP_optic_SB_11_4x20_PM","CUP_optic_SB_11_4x20_PM_pip","CUP_optic_SB_11_4x20_PM_tan","CUP_optic_SB_11_4x20_PM_tan_pip","CUP_optic_SB_11_4x20_PM_od","CUP_optic_SB_11_4x20_PM_od_PIP","CUP_optic_SB_3_12x50_PMII","CUP_optic_SB_3_12x50_PMII_PIP","CUP_optic_SB_3_12x50_PMII_Tan","CUP_optic_SB_3_12x50_PMII_Tan_PIP","CUP_optic_LeupoldMk4","CUP_optic_LeupoldMk4_pip","CUP_optic_PSO_3","CUP_optic_PSO_3_open","CUP_optic_PSO_3_open_pip"];

	// AI Weapons and Attachments
	blck_bipods = ["bipod_01_F_blk","bipod_01_F_mtp","bipod_01_F_snd","bipod_02_F_blk","bipod_02_F_hex","bipod_02_F_tan","bipod_03_F_blk","bipod_03_F_oli"];

	blck_Optics_Holo = ["optic_Hamr","optic_MRD","optic_Holosight","optic_Holosight_smg","optic_Aco","optic_ACO_grn","optic_ACO_grn_smg","optic_Aco_smg","optic_Yorris"];
	blck_Optics_Reticule = ["optic_Arco","optic_MRCO"];
	blck_Optics_Scopes = [
		"optic_AMS","optic_AMS_khk","optic_AMS_snd",
		"optic_DMS",
		"optic_KHS_blk","optic_KHS_hex","optic_KHS_old","optic_KHS_tan",
		"optic_LRPS",
		"optic_Nightstalker",
		"optic_NVS",
		"optic_SOS",
		"optic_tws"
		//"optic_tws_mg",
		];
	blck_Optics_Apex = [
		//Apex
		"optic_Arco_blk_F",	"optic_Arco_ghex_F",
		"optic_DMS_ghex_F",
		"optic_Hamr_khk_F",
		"optic_ERCO_blk_F","optic_ERCO_khk_F","optic_ERCO_snd_F",
		"optic_SOS_khk_F",
		"optic_LRPS_tna_F","optic_LRPS_ghex_F",
		"optic_Holosight_blk_F","optic_Holosight_khk_F","optic_Holosight_smg_blk_F"
		];
	blck_Optics = blck_Optics_Holo + blck_Optics_Reticule + blck_Optics_Scopes;

	#ifdef useAPEX
	blck_Optics = blck_Optics + blck_Optics_Apex;
	#endif
	blck_bipods = [
		"bipod_01_F_blk","bipod_01_F_mtp","bipod_01_F_snd","bipod_02_F_blk","bipod_02_F_hex","bipod_02_F_tan","bipod_03_F_blk","bipod_03_F_oli",
		//Apex
		"bipod_01_F_khk"
		];

	blck_silencers = [
		"muzzle_snds_acp","muzzle_snds_B",
		"muzzle_snds_H","muzzle_snds_H_MG","muzzle_snds_H_SW","muzzle_snds_L","muzzle_snds_M",
		//Apex
		"muzzle_snds_H_khk_F","muzzle_snds_H_snd_F","muzzle_snds_58_blk_F","muzzle_snds_m_khk_F","muzzle_snds_m_snd_F","muzzle_snds_B_khk_F","muzzle_snds_B_snd_F",
		"muzzle_snds_58_wdm_F","muzzle_snds_65_TI_blk_F","muzzle_snds_65_TI_hex_F","muzzle_snds_65_TI_ghex_F","muzzle_snds_H_MG_blk_F","muzzle_snds_H_MG_khk_F"
		];

	blck_RifleSniper = [ 
		"srifle_EBR_F","srifle_GM6_F","srifle_LRR_F","srifle_DMR_01_F"
	];

	blck_RifleAsault_556 = [
		"arifle_SDAR_F","arifle_TRG21_F","arifle_TRG20_F","arifle_TRG21_GL_F","arifle_Mk20_F","arifle_Mk20C_F","arifle_Mk20_GL_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F","arifle_Mk20_GL_plain_F","arifle_SDAR_F"
		];

	blck_RifleAsault_650 = [
		"arifle_Katiba_F","arifle_Katiba_C_F","arifle_Katiba_GL_F","arifle_MXC_F","arifle_MX_F","arifle_MX_GL_F","arifle_MXM_F"
		];

	blck_RifleAsault = blck_RifleAsault_556 + blck_RifleAsault_650;

	blck_RifleLMG = [
		"LMG_Mk200_F","LMG_Zafir_F"
	];

	blck_RifleOther = [
		"SMG_01_F","SMG_02_F"
	];

	blck_Pistols = [
		//"hgun_PDW2000_F","hgun_ACPC2_F","hgun_Rook40_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_Pistol_Signal_F"
		"CUP_hgun_Compact","CUP_hgun_Duty","CUP_hgun_Phantom","CUP_hgun_Glock17","CUP_hgun_Glock17_blk","CUP_hgun_Glock17_tan","CUP_hgun_M9","CUP_hgun_Makarov","CUP_hgun_PMM","CUP_hgun_PB6P9","CUP_hgun_TaurusTracker455","CUP_hgun_Colt1911","CUP_hgun_Deagle","CUP_hgun_SA61","CUP_hgun_MicroUzi","CUP_hgun_Mac10","CUP_hgun_MP7","CUP_hgun_TEC9","CUP_hgun_Mk23"
	];
	blck_Pistols_blue = blck_Pistols;
	blck_Pistols_red = blck_Pistols;
	blck_Pistols_green = blck_Pistols;
	blck_Pistols_orange = blck_Pistols;

	blck_DLC_MMG = [
				"MMG_01_hex_F","MMG_02_sand_F","MMG_01_tan_F","MMG_02_black_F","MMG_02_camo_F"
	];

	blck_DLC_Sniper = [
		"srifle_DMR_02_camo_F","srifle_DMR_02_F","srifle_DMR_02_sniper_F","srifle_DMR_03_F","srifle_DMR_03_tan_F","srifle_DMR_04_F","srifle_DMR_04_Tan_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_F","srifle_DMR_06_camo_F","srifle_DMR_06_olive_F"
	];
	blck_apexWeapons = ["arifle_AK12_F","arifle_AK12_GL_F","arifle_AKM_F","arifle_AKM_FL_F","arifle_AKS_F","arifle_ARX_blk_F","arifle_ARX_ghex_F","arifle_ARX_hex_F","arifle_CTAR_blk_F","arifle_CTAR_hex_F",
						"arifle_CTAR_ghex_F","arifle_CTAR_GL_blk_F","arifle_CTARS_blk_F","arifle_CTARS_hex_F","arifle_CTARS_ghex_F","arifle_SPAR_01_blk_F","arifle_SPAR_01_khk_F","arifle_SPAR_01_snd_F",
						"arifle_SPAR_01_GL_blk_F","arifle_SPAR_01_GL_khk_F","arifle_SPAR_01_GL_snd_F","arifle_SPAR_02_blk_F","arifle_SPAR_02_khk_F","arifle_SPAR_02_snd_F","arifle_SPAR_03_blk_F",
						"arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F","arifle_MX_khk_F","arifle_MX_GL_khk_F","arifle_MXC_khk_F","arifle_MXM_khk_F"];

	//This defines the random weapon to spawn on the AI
	//https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Weapons
	blck_WeaponList_Blue = ["CUP_srifle_Mosin_Nagant","CUP_srifle_LeeEnfield_rail","CUP_srifle_CZ550_rail","CUP_smg_MP5A5","CUP_smg_MP5A5_flashlight","CUP_sgun_Saiga12K","CUP_arifle_AKS74U","CUP_arifle_SAIGA_MK03_top_rail","CUP_arifle_SIAGE_MK03_Wood_top_rail","CUP_arifle_TYPE_56_2_Early","CUP_smg_bizon","CUP_smg_vityaz","CUP_smg_saiga9","CUP_smg_EVO","CUP_arifle_G36C","CUP_sgun_CZ584","CUP_sgun_M1014","CUP_arifle_M16A1","CUP_smg_PS90_olive","CUP_sgun_SPAS12","CUP_sgun_M1014_Entry_vfg","CUP_srifle_Remington700","CUP_SKS","CUP_SKS_rail","CUP_smg_p90_black","CUP_smg_MP5SD6"];
	blck_WeaponList_Red = ["CUP_sgun_AA12","CUP_arifle_AUG_A1","CUP_arifle_AKM","CUP_arifle_AKMS","CUP_arifle_AK47","CUP_arifle_AK74","CUP_arifle_AKS74","CUP_arifle_AK74M","CUP_arifle_AK74M_camo","CUP_arifle_AK74M_top_rail","CUP_arifle_AK107","CUP_arifle_CZ805_A1","CUP_arifle_CZ805_A2","CUP_arifle_FNFAL5060_railed","CUP_arifle_FNFAL_OSW_railed","CUP_arifle_G36A_RIS","CUP_arifle_G36K_RIS","CUP_arifle_HK416_CQB_Black","CUP_arifle_HK416_Black","CUP_arifle_HK_M27","CUP_arifle_HK417_12","CUP_arifle_L85A2","CUP_arifle_L85A2_NG","CUP_arifle_L86A2","CUP_srifle_M14","CUP_arifle_M16A2","CUP_arifle_M16A4_Grip","CUP_arifle_M4A1","CUP_arifle_M4A1_black","CUP_arifle_M4A3_black","CUP_arifle_mk18_black","CUP_arifle_SBR_black","CUP_arifle_Sa58P","CUP_arifle_Sa58V","CUP_arifle_Sa58RIS1","CUP_arifle_Sa58RIS2","CUP_arifle_Sa58P_frontris","CUP_arifle_Mk16_STD","CUP_arifle_Mk16_CQC","CUP_arifle_Mk17_CQC","CUP_arifle_Mk17_STD","CUP_arifle_XM8_Carbine","CUP_arifle_XM8_Compact_Rail","CUP_lmg_UK59","CUP_Famas_F1_Rail","CUP_arifle_G3A3_ris","CUP_arifle_ACR_blk_556","CUP_arifle_Galil_556_black","CUP_arifle_Galil_SAR_black","CUP_arifle_X95","CUP_arifle_Fort224","CUP_arifle_Fort221","CUP_arifle_FNFAL5061_wooden_railed","CUP_arifle_DSA_SA58","CUP_arifle_DSA_SA58_OSW"];
	blck_WeaponList_Green = blck_WeaponList_Red + ["CUP_arifle_AKS74U_railed","CUP_arifle_AK74M_railed","CUP_arifle_RPK74","CUP_arifle_RPK74M","CUP_arifle_G36A","CUP_arifle_MG36","CUP_lmg_L110A1","CUP_lmg_minimipara","CUP_lmg_minimi","CUP_lmg_M249_E2","CUP_lmg_M249","CUP_arifle_DSA_SA58_DMR","CUP_arifle_CZ805_B"];
	blck_WeaponList_Orange = blck_WeaponList_Red + ["CUP_arifle_RPK74","CUP_arifle_RPK74M","CUP_arifle_CZ805_GL","CUP_arifle_G36A","CUP_arifle_MG36","CUP_arifle_HK417_20","CUP_lmg_L110A1","CUP_srifle_L129A1","CUP_srifle_M110","CUP_srifle_Mk12SPR","CUP_lmg_M240","CUP_lmg_L7A2","CUP_lmg_FNMAG","CUP_lmg_minimipara","CUP_lmg_minimi","CUP_lmg_M249_E2","CUP_lmg_M249","CUP_lmg_m249_pip3","CUP_lmg_m249_pip4","CUP_lmg_M60","CUP_lmg_M60E4","CUP_lmg_MG3_rail","CUP_lmg_Mk48","CUP_lmg_PKMN","CUP_lmg_Pecheneg","CUP_arifle_Mk16_SV","CUP_arifle_Mk20","CUP_arifle_xm8_sharpshooter","CUP_arifle_xm8_SAW","CUP_srifle_DMR","CUP_srifle_M24_blk","CUP_srifle_M40A3","CUP_srifle_SVD","CUP_srifle_SVD_top_rail","CUP_srifle_RSASS_Black","CUP_srifle_m110_kac","CUP_srifle_G22_wdl"];

	#ifdef useAPEX
		blck_WeaponList_Orange = blck_WeaponList_Orange + blck_apexWeapons;
		blck_WeaponList_Green = blck_WeaponList_Green + blck_apexWeapons;
	#endif

	blck_backpacks = ["B_Carryall_ocamo","B_Carryall_oucamo","B_Carryall_mcamo","B_Carryall_oli","B_Carryall_khk","B_Carryall_cbr" ];  
	blck_ApexBackpacks = [
		"B_Bergen_mcamo_F","B_Bergen_dgtl_F","B_Bergen_hex_F","B_Bergen_tna_F","B_AssaultPack_tna_F","B_Carryall_ghex_F",
		"B_FieldPack_ghex_F","B_ViperHarness_blk_F","B_ViperHarness_ghex_F","B_ViperHarness_hex_F","B_ViperHarness_khk_F",
		"B_ViperHarness_oli_F","B_ViperLightHarness_blk_F","B_ViperLightHarness_ghex_F","B_ViperLightHarness_hex_F","B_ViperLightHarness_khk_F","B_ViperLightHarness_oli_F"
		];

	#ifdef useAPEX
		blck_backpacks = blck_backpacks + blck_ApexBackpacks;
	#endif
	blck_backpacks_blue = ["B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_ocamo","B_AssaultPack_rgr","B_AssaultPack_sgg","B_FieldPack_blk","B_FieldPack_cbr","B_FieldPack_khk","B_FieldPack_ocamo","B_FieldPack_oli","B_FieldPack_oucamo","smallbackpack_red_epoch","smallbackpack_green_epoch","smallbackpack_teal_epoch","smallbackpack_pink_epoch"];
	blck_backpacks_red = ["B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_ocamo","B_AssaultPack_rgr","B_AssaultPack_sgg","smallbackpack_red_epoch","smallbackpack_green_epoch","smallbackpack_teal_epoch","smallbackpack_pink_epoch"];
	blck_backpacks_green = ["B_FieldPack_blk","B_FieldPack_cbr","B_FieldPack_khk","B_FieldPack_ocamo","B_FieldPack_oli","B_FieldPack_oucamo","B_Kitbag_cbr","B_Kitbag_mcamo","B_Kitbag_rgr","B_Kitbag_sgg","B_Parachute","B_TacticalPack_blk","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_oli","B_TacticalPack_rgr"];
	blck_backpacks_orange = ["B_Carryall_cbr","B_Carryall_khk","B_Carryall_mcamo","B_Carryall_ocamo","B_Carryall_oli","B_Carryall_oucamo","B_Kitbag_cbr","B_Kitbag_mcamo","B_Kitbag_rgr","B_Kitbag_sgg","B_Parachute","B_TacticalPack_blk","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_oli","B_TacticalPack_rgr"];

	blck_BanditHeadgear = ["H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH","H_70_EPOCH","wolf_mask_epoch"];
	//This defines the skin list, some skins are disabled by default to permit players to have high visibility uniforms distinct from those of the AI.
	blck_headgear = [
			"H_11_EPOCH","H_28_EPOCH","H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_70_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH","H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_93_EPOCH","H_104_EPOCH"
	];
	blck_helmets = [
			"H_1_EPOCH","H_2_EPOCH","H_3_EPOCH","H_4_EPOCH","H_5_EPOCH","H_6_EPOCH","H_7_EPOCH","H_8_EPOCH","H_9_EPOCH","H_10_EPOCH","H_12_EPOCH","H_13_EPOCH","H_14_EPOCH","H_15_EPOCH","H_16_EPOCH","H_17_EPOCH","H_18_EPOCH","H_23_EPOCH","H_24_EPOCH","H_25_EPOCH","H_26_EPOCH","H_27_EPOCH","H_32_EPOCH","H_33_EPOCH","H_35_EPOCH","H_36_EPOCH","H_37_EPOCH","H_38_EPOCH"
	];
	blck_headgearList = blck_headgear + blck_helmets;
	blck_headgear_blue = ["H_4_EPOCH","H_11_EPOCH","H_14_EPOCH","H_15_EPOCH","H_16_EPOCH","H_17_EPOCH","H_18_EPOCH","H_28_EPOCH","H_32_EPOCH","H_33_EPOCH","H_34_EPOCH","H_35_EPOCH","H_36_EPOCH","H_37_EPOCH","H_38_EPOCH","H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH","H_70_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH","H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_104_EPOCH"];
	blck_headgear_red = ["H_11_EPOCH","H_28_EPOCH","H_39_EPOCH","H_40_EPOCH","H_41_EPOCH","H_42_EPOCH","H_43_EPOCH","H_44_EPOCH","H_45_EPOCH","H_46_EPOCH","H_47_EPOCH","H_48_EPOCH","H_49_EPOCH","H_50_EPOCH","H_51_EPOCH","H_52_EPOCH","H_53_EPOCH","H_54_EPOCH","H_55_EPOCH","H_56_EPOCH","H_57_EPOCH","H_58_EPOCH","H_59_EPOCH","H_60_EPOCH","H_61_EPOCH","H_62_EPOCH","H_63_EPOCH","H_64_EPOCH","H_65_EPOCH","H_66_EPOCH","H_67_EPOCH","H_68_EPOCH","H_69_EPOCH","H_70_EPOCH","H_71_EPOCH","H_72_EPOCH","H_73_EPOCH","H_74_EPOCH","H_75_EPOCH","H_76_EPOCH","H_77_EPOCH","H_78_EPOCH","H_79_EPOCH","H_80_EPOCH","H_81_EPOCH","H_82_EPOCH","H_83_EPOCH","H_84_EPOCH","H_85_EPOCH","H_86_EPOCH","H_87_EPOCH","H_88_EPOCH","H_89_EPOCH","H_90_EPOCH","H_91_EPOCH","H_92_EPOCH","H_93_EPOCH","H_104_EPOCH"];
	blck_headgear_green = ["H_1_EPOCH","H_2_EPOCH","H_3_EPOCH","H_4_EPOCH","H_5_EPOCH","H_6_EPOCH","H_7_EPOCH","H_8_EPOCH","H_9_EPOCH","H_10_EPOCH","H_12_EPOCH","H_13_EPOCH","H_14_EPOCH","H_15_EPOCH","H_16_EPOCH","H_17_EPOCH","H_18_EPOCH","H_23_EPOCH","H_24_EPOCH","H_25_EPOCH","H_26_EPOCH","H_27_EPOCH","H_32_EPOCH","H_33_EPOCH","H_35_EPOCH","H_36_EPOCH","H_37_EPOCH","H_38_EPOCH"];
	blck_headgear_orange = ["H_1_EPOCH","H_2_EPOCH","H_3_EPOCH","H_5_EPOCH","H_6_EPOCH","H_7_EPOCH","H_8_EPOCH","H_9_EPOCH","H_10_EPOCH","H_12_EPOCH","H_13_EPOCH","H_19_EPOCH","H_20_EPOCH","H_21_EPOCH","H_22_EPOCH","H_23_EPOCH","H_24_EPOCH","H_25_EPOCH","H_26_EPOCH","H_27_EPOCH","H_29_EPOCH","H_30_EPOCH","H_31_EPOCH","H_93_EPOCH","H_94_EPOCH","H_95_EPOCH","H_96_EPOCH","H_97_EPOCH","H_98_EPOCH","H_99_EPOCH","H_100_EPOCH","H_101_EPOCH","H_102_EPOCH","H_103_EPOCH"];

	//This defines the skin list, some skins are disabled by default to permit players to have high visibility uniforms distinct from those of the AI.
	blck_SkinList_Male = [
		//https://community.bistudio.com/wiki/Arma_3_CfgWeapons_Equipment
		"U_OG_Guerilla1_1", "U_OG_Guerilla2_1", "U_OG_Guerilla2_3", "U_OG_Guerilla3_1", "U_OG_Guerilla3_2", "U_OG_leader", "U_CamoRed_uniform", "U_CamoBrn_uniform", "U_CamoBlue_uniform", "U_Camo_uniform"
		];
		blck_femaleUniformsEpoch = [
				"U_CamoBlue_uniform", "U_CamoBrn_uniform", "U_CamoPinkPolka_uniform","U_CamoPink_uniform","U_CamoOutback_uniform",
				"U_CamoBubblegum_uniform","U_CamoBiker_uniform","U_CamoAloha_uniform","U_CamoRed_uniform"
		];
		blck_femaleWetsuitsEpoch = [
			"U_Wetsuit_uniform","U_Wetsuit_White","U_Wetsuit_Blue","U_Wetsuit_Purp","U_Wetsuit_Camo"
		];
		blck_SkinList = blck_femaleUniformsEpoch + blck_SkinList_Male;
		blck_SkinList_blue = ["U_O_PilotCoveralls","U_OG_Guerilla1_1","U_OG_Guerilla2_1","U_OG_Guerilla2_3","U_OG_Guerilla3_1","U_OG_Guerilla3_2","U_OG_leader","U_C_Poloshirt_stripped","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite","U_C_Poor_1","U_C_WorkerCoveralls","U_C_Journalist","U_C_Scientist","U_OrestesBody","U_C_Driver_1","U_C_Driver_2","U_C_Driver_3","U_C_Driver_4","U_C_Driver_1_black","U_C_Driver_1_blue","U_C_Driver_1_green","U_C_Driver_1_red","U_C_Driver_1_white","U_C_Driver_1_yellow","U_C_Driver_1_orange","U_C_Driver_1_red"];
		blck_SkinList_red = ["U_O_PilotCoveralls","U_O_Wetsuit","U_OG_Guerilla1_1","U_OG_Guerilla2_1","U_OG_Guerilla2_3","U_OG_Guerilla3_1","U_OG_Guerilla3_2","U_OG_leader","U_C_Poloshirt_stripped","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite","U_C_Poor_1","U_C_WorkerCoveralls","U_C_Journalist","U_C_Scientist","U_OrestesBody","U_C_Driver_1","U_C_Driver_2","U_C_Driver_3","U_C_Driver_4","U_C_Driver_1_black","U_C_Driver_1_blue","U_C_Driver_1_green","U_C_Driver_1_red","U_C_Driver_1_white","U_C_Driver_1_yellow","U_C_Driver_1_orange","U_C_Driver_1_red"];
		blck_SkinList_green = ["U_OG_Guerilla1_1","U_OG_Guerilla2_1","U_OG_Guerilla2_3","U_OG_Guerilla3_1","U_OG_Guerilla3_2","U_OG_leader","U_CamoRed_uniform","U_CamoBrn_uniform","U_CamoBlue_uniform","U_Camo_uniform","U_ghillie1_uniform","U_ghillie2_uniform","U_ghillie3_uniform"];
		blck_SkinList_orange = ["U_O_CombatUniform_ocamo","U_O_GhillieSuit","U_CamoRed_uniform","U_CamoBrn_uniform","U_CamoBlue_uniform","U_Camo_uniform","U_ghillie1_uniform","U_ghillie2_uniform","U_ghillie3_uniform"];

		blck_vests = [
			"V_1_EPOCH", "V_2_EPOCH", "V_3_EPOCH", "V_4_EPOCH", "V_5_EPOCH", "V_6_EPOCH", "V_10_EPOCH", "V_11_EPOCH", "V_12_EPOCH", "V_13_EPOCH", "V_14_EPOCH", "V_15_EPOCH", "V_16_EPOCH", "V_17_EPOCH", "V_18_EPOCH", "V_19_EPOCH", "V_20_EPOCH", "V_21_EPOCH", "V_22_EPOCH", "V_24_EPOCH", "V_25_EPOCH", "V_27_EPOCH", "V_28_EPOCH", "V_29_EPOCH", "V_30_EPOCH", "V_31_EPOCH", "V_32_EPOCH", "V_33_EPOCH", "V_36_EPOCH", "V_38_EPOCH", "V_40_EPOCH"
		];
		blck_vests_blue = ["V_1_EPOCH","V_2_EPOCH","V_3_EPOCH","V_4_EPOCH","V_5_EPOCH","V_6_EPOCH","V_10_EPOCH","V_11_EPOCH","V_12_EPOCH","V_13_EPOCH","V_14_EPOCH","V_15_EPOCH","V_16_EPOCH","V_17_EPOCH","V_18_EPOCH","V_19_EPOCH","V_20_EPOCH","V_21_EPOCH","V_22_EPOCH","V_24_EPOCH","V_25_EPOCH","V_27_EPOCH","V_28_EPOCH","V_29_EPOCH","V_30_EPOCH","V_31_EPOCH","V_32_EPOCH","V_33_EPOCH","V_36_EPOCH","V_38_EPOCH","V_40_EPOCH"];
		blck_vests_red = ["V_1_EPOCH","V_2_EPOCH","V_3_EPOCH","V_4_EPOCH","V_5_EPOCH","V_10_EPOCH","V_11_EPOCH","V_12_EPOCH","V_17_EPOCH","V_18_EPOCH","V_21_EPOCH","V_24_EPOCH","V_29_EPOCH","V_30_EPOCH","V_31_EPOCH","V_32_EPOCH"];
		blck_vests_green = ["V_6_EPOCH","V_7_EPOCH","V_8_EPOCH","V_13_EPOCH","V_14_EPOCH","V_15_EPOCH","V_16_EPOCH","V_19_EPOCH","V_20_EPOCH","V_22_EPOCH","V_23_EPOCH","V_25_EPOCH","V_27_EPOCH","V_28_EPOCH","V_33_EPOCH","V_34_EPOCH","V_36_EPOCH","V_37_EPOCH","V_38_EPOCH","V_39_EPOCH","V_40_EPOCH"];
		blck_vests_orange = ["V_9_EPOCH","V_23_EPOCH","V_26_EPOCH","V_35_EPOCH"];

			//CraftingFood
        blck_Meats=[
            "SnakeCarcass_EPOCH","RabbitCarcass_EPOCH","ChickenCarcass_EPOCH","GoatCarcass_EPOCH","SheepCarcass_EPOCH","DogCarcass_EPOCH","ItemTrout","ItemSeaBass","ItemTuna"
        ];
        blck_Drink = [
            "WhiskeyNoodle","ItemSodaAlpineDude","ItemSodaOrangeSherbet","ItemSodaPurple","ItemSodaMocha","ItemSodaBurst","ItemSodaRbull","FoodWalkNSons"
        ];
        blck_Food = [
            "HotAxeSauce_epoch","gyro_wrap_epoch","icecream_epoch","redburger_epoch","bluburger_epoch","krypto_candy_epoch","ItemBakedBeans","ItemRiceBox","ItemPowderMilk","ItemCereals",
			"FoodBioMeat","FoodMeeps","FoodSnooter","sardines_epoch","meatballs_epoch","scam_epoch","sweetcorn_epoch","honey_epoch","CookedSheep_EPOCH","CookedGoat_EPOCH","SnakeMeat_EPOCH",
            "CookedRabbit_EPOCH","CookedChicken_EPOCH","CookedDog_EPOCH","ItemTroutCooked","ItemSeaBassCooked","ItemTunaCooked","TacticalBacon"
        ];
        blck_ConsumableItems = blck_Meats + blck_Drink + blck_Food;
		blck_throwableExplosives = ["HandGrenade","MiniGrenade"];
		blck_otherExplosives = ["1Rnd_HE_Grenade_shell","3Rnd_HE_Grenade_shell","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag"];
		blck_explosives = blck_throwableExplosives + blck_otherExplosives;
		blck_medicalItems = ["FAK", "ItemVitamins", "morphine_epoch", "iodide_pills_epoch", "adrenaline_epoch", 
				"caffeinepills_epoch", "orlistat_epoch", "ItemCanteen_Empty", "ItemCanteen_Clean", "ItemBottlePlastic_Empty", 
				"ItemBottlePlastic_Clean", "atropine_epoch", "ItemWaterPurificationTablets", "ItemPainKillers", "ItemDefibrillator", 
				"ItemBloodBag_Empty", "ItemBloodBag_Full", "ItemAntibiotic", "nanite_cream_epoch", "nanite_pills_epoch"];
		blck_specialItems = blck_throwableExplosives + blck_medicalItems;
		blck_NVG = ["NVG_EPOCH"];
		blck_epochValuables = ["PartOreGold","PartOreSilver","PartOre","ItemGoldBar","ItemSilverBar",
			"ItemGoldBar10oz","ItemTopaz","ItemOnyx","ItemSapphire","ItemAmethyst",
			"ItemEmerald","ItemCitrine","ItemRuby","ItemQuartz","ItemJade",
			"ItemGarnet","ItemKiloHemp"];
        blck_epochBuildingSupplies = ["PartPlankPack","ItemPlywoodPack","CinderBlocks","MortarBucket","ItemScraps",
            "ItemCorrugated","ItemCorrugatedLg","CircuitParts","WoodLog_EPOCH","ItemRope","ItemStick","ItemRock","ItemBurlap","ItemBulb","ItemSolar","ItemCables","ItemBattery","Pelt_EPOCH","JackKit","ItemCanvas","ItemSeedBag","ItemPipe"];
        blck_epochVehicleRepair = ["EngineParts","FuelTank","SpareTire","ItemGlass",
           "ItemDuctTape","VehicleRepair"];
        blck_buildingMaterials = blck_epochBuildingSupplies + blck_epochVehicleRepair;

/***************************************************************************************
DEFAULT CONTENTS OF LOOT CRATES FOR EACH MISSION
Note however that these configurations can be used in any way you like or replaced with mission-specific customized loot arrays
for examples of how you can do this see \Major\Compositions.sqf
***************************************************************************************/

	// values are: number of things from the weapons, magazines, optics, materials(cinder etc), items (food etc) and backpacks arrays to add, respectively.
	blck_lootCountsOrange = [2,12,2,12,8,1];   // Orange
	blck_lootCountsGreen = [2,10,2,8,6,1]; // Green
	blck_lootCountsRed = [1,8,1,6,5,1];  // Red
	blck_lootCountsBlue = [1,4,1,4,4,1];   // Blue

	blck_BoxLoot_Orange = 
		// Loot is grouped as [weapons],[magazines],[items] in order to be able to use the correct function to load the item into the crate later on.
		// Each item consist of the following information ["ItemName",minNum, maxNum] where min is the smallest number added and min+max is the largest number added.
		//[Extreme]
		[  
			[// Weapons
			/*
				#ifdef useAPEX
				"arifle_AK12_F","arifle_AK12_GL_F","arifle_AKM_F","arifle_AKM_FL_F","arifle_AKS_F","arifle_ARX_blk_F","arifle_ARX_ghex_F","arifle_ARX_hex_F","arifle_CTAR_blk_F","arifle_CTAR_hex_F",
				"arifle_CTAR_ghex_F","arifle_CTAR_GL_blk_F","arifle_CTARS_blk_F","arifle_CTARS_hex_F","arifle_CTARS_ghex_F","arifle_SPAR_01_blk_F","arifle_SPAR_01_khk_F","arifle_SPAR_01_snd_F",
				"arifle_SPAR_01_GL_blk_F","arifle_SPAR_01_GL_khk_F","arifle_SPAR_01_GL_snd_F","arifle_SPAR_02_blk_F","arifle_SPAR_02_khk_F","arifle_SPAR_02_snd_F","arifle_SPAR_03_blk_F",
				"arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F","arifle_MX_khk_F","arifle_MX_GL_khk_F","arifle_MXC_khk_F","arifle_MXM_khk_F",
				#endif
				["MultiGun","EnergyPackLg"],
				["arifle_Katiba_F","30Rnd_65x39_caseless_green"],
				["arifle_Katiba_GL_F","30Rnd_65x39_caseless_green"],
				["arifle_MX_F","30Rnd_65x39_caseless_mag"],
				["arifle_MXC_F","30Rnd_65x39_caseless_mag"],
				["arifle_MXM_F","30Rnd_65x39_caseless_mag"],
				["arifle_SDAR_F","20Rnd_556x45_UW_mag"],
				["arifle_TRG20_F","30Rnd_556x45_Stanag"],
				["M14_EPOCH","20Rnd_762x51_Mag"],
				["M14Grn_EPOCH","20Rnd_762x51_Mag"],
				["M14_EPOCH","20Rnd_762x51_Mag"],
				["M14Grn_EPOCH","20Rnd_762x51_Mag"],
				["arifle_MXM_F","30Rnd_65x39_caseless_mag_Tracer"],
				["arifle_MXM_Black_F","30Rnd_65x39_caseless_mag_Tracer"],
				["srifle_DMR_01_F","10Rnd_762x54_Mag"],
				["srifle_LRR_F","7Rnd_408_Mag"],
				["srifle_EBR_F","20Rnd_762x51_Mag"],
				["Arifle_MX_SW_F","100Rnd_65x39_caseless_mag_Tracer"],
				["Arifle_MX_SW_Black_F","100Rnd_65x39_caseless_mag_Tracer"],
				["LMG_Zafir_F","150Rnd_762x54_Box"],
				["MMG_01_hex_F","150Rnd_93x64_Mag"],
				["MMG_01_tan_F","150Rnd_93x64_Mag"],
				["MMG_02_black_F","130Rnd_338_Mag"],
				["MMG_02_camo_F","130Rnd_338_Mag"],
				["MMG_02_sand_F","130Rnd_338_Mag"],
				["srifle_DMR_06_olive_F","20Rnd_762x51_Mag"]
			*/
			],
			[//Magazines
			/*
				["3rnd_HE_Grenade_Shell",3,6],
				["30Rnd_65x39_caseless_green",3,6],
				["30Rnd_556x45_Stanag",3,6],
				["30Rnd_45ACP_Mag_SMG_01",3,6],
				["20Rnd_556x45_UW_mag",3,6],
				["20Rnd_762x51_Mag",7,14],
				["200Rnd_65x39_cased_Box",3,6],
				["100Rnd_65x39_caseless_mag_Tracer",3,6],
				["3rnd_HE_Grenade_Shell",1,3],
				["HandGrenade",1,4],
				["EnergyPack",2,5],
				// Marksman Pack Ammo
				["10Rnd_338_Mag",1,4],
				["10Rnd_338_Mag",1,4],
				["10Rnd_127x54_Mag" ,1,4],
				["10Rnd_127x54_Mag",1,4],
				["10Rnd_93x64_DMR_05_Mag" ,1,4],
				["10Rnd_93x64_DMR_05_Mag" ,1,4],
				// Apex Ammo
				["130Rnd_338_Mag",1,3],
				["150Rnd_93x64_Mag",1,3]
			*/
			],
			[  // Optics
			/*
				["optic_SOS",1,2],["optic_LRPS",1,2],["optic_DMS",1,2],["optic_KHS_blk",1,3],["optic_KHS_hex",1,3],["optic_KHS_old",1,3],
				["optic_Arco",1,3],["optic_Hamr",1,3],["optic_MRCO",1,3],["optic_NVS",1,3],["optic_Nightstalker",1,2],["acc_flashlight",1,3],["acc_pointer_IR",1,3],
				["muzzle_snds_H",1,3],["muzzle_snds_L",1,3],["muzzle_snds_M",1,3],["muzzle_snds_B",1,3],["muzzle_snds_H_MG",1,3],["muzzle_snds_acp",1,3]
			*/
			],
			[// Materials and supplies
				["CinderBlocks",5,15],
				["jerrycan_epoch",1,2],
				["lighter_epoch",1,2],
				["CircuitParts",2,3],
				["WoodLog_EPOCH",5,10],
				["ItemCorrugatedLg",1,6],
				["ItemCorrugated",3,10],
				["ItemMixOil",1,2],
				["MortarBucket",5,10],
				["PartPlankPack",10,19],
				["ItemLockbox",1,2],
				["ItemSolar",1,2],
				["ItemCables",1,2],
				["ItemBattery",1,2],
				["Pelt_EPOCH",1,2],
				["EnergyPackLg",1,3],
				["ItemCanvas",2,4],
				["ItemKiloHemp",1,3],
				["ItemRope",1,3],
				["ItemBurlap",1,3],
				["ItemCanvas",1,3],
				["ItemCorrugated",1,3],
				["VehicleRepairLg",1,3],
				["EngineParts",1,3],
				["FuelTank",1,3],
				["CSGAS",1,2],
				["SpareTire",2,4],
				["ItemRotor",1,2],
				["EngineBlock",1,2],
				["ItemDuctTape",1,3]
			],
			[//Items
				["Heal_EPOCH",1,2],["Defib_EPOCH",1,2],["Repair_EPOCH",1,4],["FAK",1,4],["VehicleRepair",1,3],["Rangefinder",1,3],["ItemJade",1,2],["ItemQuartz",1,2],["ItemRuby",1,2],["ItemSapphire",1,2],
				["ItemKiloHemp",1,2],["ItemRuby",1,2],["ItemSilverBar",1,2],["ItemEmerald",1,2],["ItemTopaz",1,2],["ItemOnyx",1,2],["ItemSapphire",1,2],["ItemAmethyst",1,2],
				["ItemSodaRbull",1,3],["ItemSodaOrangeSherbet",1,3],["ItemSodaPurple",1,3],["ItemSodaMocha",1,3],["ItemSodaBurst",1,3],
				["CookedChicken_EPOCH",1,3],["CookedGoat_EPOCH",1,3],["CookedSheep_EPOCH",1,3],["FoodSnooter",1,3],["FoodMeeps",1,3],["FoodBioMeat",1,3],["ItemTuna",1,3],["ItemSeaBass",1,3],["ItemTrout",1,3],
				"FAK" , "Towelette" , "ItemVitamins", "morphine_epoch", "iodide_pills_epoch", "adrenaline_epoch", 
				"caffeinepills_epoch", "orlistat_epoch", "ItemCanteen_Empty", "ItemCanteen_Clean", "ItemBottlePlastic_Empty", 
				"ItemBottlePlastic_Clean", "atropine_epoch", "ItemWaterPurificationTablets", "ItemPainKillers", "ItemDefibrillator", 
				"ItemBloodBag_Empty", "ItemBloodBag_Full", "ItemAntibiotic", "nanite_cream_epoch", "nanite_pills_epoch"
			],
			[ // Backpacks
				["B_Carryall_cbr",1,2],["B_Carryall_khk",1,2],["B_Carryall_mcamo",1,2],["B_Carryall_ocamo",1,2],["B_Carryall_oli",1,2],["B_Carryall_oucamo",1,2],["B_FieldPack_blk",1,2],
				["B_FieldPack_cbr",1,2],["B_FieldPack_khk",1,2],["B_FieldPack_ocamo",1,2],["B_FieldPack_oli",1,2],["B_FieldPack_oucamo",1,2],["B_Kitbag_cbr",1,2],["B_Kitbag_mcamo",1,2],
				["B_Kitbag_rgr",1,2],["B_Kitbag_sgg",1,2],["B_Parachute",1,2],["B_TacticalPack_blk",1,2],["B_TacticalPack_mcamo",1,2],["B_TacticalPack_ocamo",1,2],["B_TacticalPack_oli",1,2],
				["B_TacticalPack_rgr",1,2]
			]
	];

	blck_BoxLoot_Green = 
		//[Hard]
		[
			[// Weapons
			/*
				// Format is ["Weapon Name","Magazine Name"],
				#ifdef useAPEX
				"arifle_AK12_F","arifle_AK12_GL_F","arifle_AKM_F","arifle_AKM_FL_F","arifle_AKS_F","arifle_ARX_blk_F","arifle_ARX_ghex_F","arifle_ARX_hex_F","arifle_CTAR_blk_F","arifle_CTAR_hex_F",
				"arifle_CTAR_ghex_F","arifle_CTAR_GL_blk_F","arifle_CTARS_blk_F","arifle_CTARS_hex_F","arifle_CTARS_ghex_F","arifle_SPAR_01_blk_F","arifle_SPAR_01_khk_F","arifle_SPAR_01_snd_F",
				"arifle_SPAR_01_GL_blk_F","arifle_SPAR_01_GL_khk_F","arifle_SPAR_01_GL_snd_F","arifle_SPAR_02_blk_F","arifle_SPAR_02_khk_F","arifle_SPAR_02_snd_F","arifle_SPAR_03_blk_F",
				"arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F","arifle_MX_khk_F","arifle_MX_GL_khk_F","arifle_MXC_khk_F","arifle_MXM_khk_F",
				#endif
				["MultiGun","EnergyPackLg"],
				["arifle_Katiba_F","30Rnd_65x39_caseless_green"],
				["arifle_Katiba_GL_F","30Rnd_65x39_caseless_green"],
				["arifle_MX_F","30Rnd_65x39_caseless_mag"],
				["arifle_MX_GL_F","30Rnd_65x39_caseless_mag"],
				["arifle_MXC_F","30Rnd_65x39_caseless_mag"],
				["arifle_MXM_F","30Rnd_65x39_caseless_mag"],
				["M14_EPOCH","20Rnd_762x51_Mag"],
				["M14Grn_EPOCH","20Rnd_762x51_Mag"],
				["M14_EPOCH","20Rnd_762x51_Mag"],
				["M14Grn_EPOCH","20Rnd_762x51_Mag"],
				["arifle_MXM_F","30Rnd_65x39_caseless_mag_Tracer"],
				["arifle_MXM_Black_F","30Rnd_65x39_caseless_mag_Tracer"],
				["srifle_DMR_01_F","10Rnd_762x54_Mag"],
				["srifle_LRR_F","7Rnd_408_Mag"],
				["srifle_EBR_F","20Rnd_762x51_Mag"],
				["LMG_Mk200_F","200Rnd_65x39_cased_Box_Tracer"],
				["Arifle_MX_SW_F","100Rnd_65x39_caseless_mag_Tracer"],
				["Arifle_MX_SW_Black_F","100Rnd_65x39_caseless_mag_Tracer"],
				["LMG_Zafir_F","150Rnd_762x54_Box"],
				["MMG_01_hex_F","150Rnd_93x64_Mag"],
				["MMG_01_tan_F","150Rnd_93x64_Mag"],
				["MMG_02_black_F","130Rnd_338_Mag"],
				["MMG_02_camo_F","130Rnd_338_Mag"],
				["MMG_02_sand_F","130Rnd_338_Mag"],
				["srifle_DMR_06_olive_F","20Rnd_762x51_Mag"]
			*/
			],
			[//Magazines
			/*
				// Format is ["Magazine name, Minimum number to add, Maximum number to add],
				["3rnd_HE_Grenade_Shell",2,4],
				["30Rnd_65x39_caseless_green",3,6],
				["30Rnd_556x45_Stanag",3,6],
				["30Rnd_556x45_Stanag",3,6],
				["30Rnd_45ACP_Mag_SMG_01",3,6],
				["20Rnd_556x45_UW_mag",3,6],
				["20Rnd_762x51_Mag",6,12],
				["200Rnd_65x39_cased_Box",3,6],
				["100Rnd_65x39_caseless_mag_Tracer",3,6],
				["3rnd_HE_Grenade_Shell",1,3],
				["HandGrenade",1,3],
				["EnergyPack",2,5],
				// Marksman Pack Ammo
				["10Rnd_338_Mag",1,4],
				["10Rnd_338_Mag",1,4],
				["10Rnd_127x54_Mag" ,1,4],
				["10Rnd_127x54_Mag",1,4],
				["10Rnd_93x64_DMR_05_Mag" ,1,4],
				["10Rnd_93x64_DMR_05_Mag" ,1,4]
			*/
			],
			[  // Optics
			/*
				["optic_Aco",1,3],["optic_ACO_grn",1,3],["optic_Aco_smg",1,3],["optic_ACO_grn_smg",1,3],["optic_Holosight",1,3],["optic_Holosight_smg",1,3],["acc_flashlight",1,3],
				["optic_Arco",1,3],["optic_Hamr",1,3],["optic_SOS",1,2],["optic_LRPS",1,2],["optic_MRCO",1,3],["optic_DMS",1,3],["optic_NVS",1,3]
			*/
			],
			[
				["CinderBlocks",5,15],
				["jerrycan_epoch",1,2],
				["lighter_epoch",1,2],
				["CircuitParts",2,3],
				["WoodLog_EPOCH",5,10],
				["ItemCorrugatedLg",1,6],
				["ItemCorrugated",3,10],
				["ItemMixOil",1,2],
				["MortarBucket",5,10],
				["PartPlankPack",10,19],
				["ItemLockbox",1,2],
				["ItemSolar",1,2],
				["ItemCables",1,2],
				["ItemBattery",1,2],
				["Pelt_EPOCH",1,2],
				["EnergyPackLg",1,3],
				["ItemCanvas",2,4],
				["ItemKiloHemp",1,3],
				["ItemRope",1,3],
				["ItemBurlap",1,3],
				["ItemCanvas",1,3],
				["ItemCorrugated",1,3],
				["VehicleRepairLg",1,3],
				["EngineParts",1,3],
				["FuelTank",1,3],
				["CSGAS",1,2],
				["SpareTire",2,4],
				["ItemRotor",1,2],
				["EngineBlock",1,2],
				["ItemDuctTape",1,3]
			],
			[//Items
				// Format is ["Item name, Minimum number to add, Maximum number to add],
				["Heal_EPOCH",1,2],["Defib_EPOCH",1,2],["Repair_EPOCH",1,2],["FAK",1,2],["FAK",1,2],["FAK",1,2],["FAK",1,2],["FAK",1,2],["FAK",1,2],["VehicleRepair",1,3],["Rangefinder",1,3],
				["ItemKiloHemp",1,2],["ItemRuby",1,2],["ItemSilverBar",1,2],["ItemGoldBar10oz",1,2],
				["ItemSodaRbull",1,3],["ItemSodaOrangeSherbet",1,3],["ItemSodaPurple",1,3],["ItemSodaMocha",1,3],["ItemSodaBurst",1,3],
				["CookedChicken_EPOCH",1,3],["CookedGoat_EPOCH",1,3],["CookedSheep_EPOCH",1,3],["FoodSnooter",1,3],["FoodMeeps",1,3],["FoodBioMeat",1,3],["ItemTuna",1,3],["ItemSeaBass",1,3],["ItemTrout",1,3],
				"FAK" , "Towelette" , "ItemVitamins", "morphine_epoch", "iodide_pills_epoch", "adrenaline_epoch", 
				"caffeinepills_epoch", "orlistat_epoch", "ItemCanteen_Empty", "ItemCanteen_Clean", "ItemBottlePlastic_Empty", 
				"ItemBottlePlastic_Clean", "atropine_epoch", "ItemWaterPurificationTablets", "ItemPainKillers", "ItemDefibrillator", 
				"ItemBloodBag_Empty", "ItemBloodBag_Full", "ItemAntibiotic", "nanite_cream_epoch", "nanite_pills_epoch"
			],
			[ // Backpacks
				["B_FieldPack_blk",1,2],["B_FieldPack_cbr",1,2],["B_FieldPack_khk",1,2],["B_FieldPack_ocamo",1,2],["B_FieldPack_oli",1,2],["B_FieldPack_oucamo",1,2],["B_Kitbag_cbr",1,2],["B_Kitbag_mcamo",1,2],
				["B_Kitbag_rgr",1,2],["B_Kitbag_sgg",1,2],["B_Parachute",1,2],["B_TacticalPack_blk",1,2],["B_TacticalPack_mcamo",1,2],["B_TacticalPack_ocamo",1,2],["B_TacticalPack_oli",1,2],["B_TacticalPack_rgr",1,2]
			]
		];

	blck_BoxLoot_Blue = 
		//[Easy]
		[
			[// Weapons
			/*
				["MultiGun","EnergyPackLg"],
				["arifle_Katiba_F","30Rnd_65x39_caseless_green"],
				["arifle_Katiba_GL_F","30Rnd_65x39_caseless_green"],
				["arifle_Mk20_F","30Rnd_556x45_Stanag"],
				["arifle_Mk20_plain_F","30Rnd_556x45_Stanag"],
				["arifle_Mk20C_F","30Rnd_556x45_Stanag"],
				["arifle_Mk20_GL_F","30Rnd_556x45_Stanag"],
				["arifle_Mk20_GL_plain_F","30Rnd_556x45_Stanag"],
				["arifle_MX_F","30Rnd_65x39_caseless_mag"],
				["arifle_MX_GL_F","30Rnd_65x39_caseless_mag"],
				["arifle_MXC_F","30Rnd_65x39_caseless_mag"],
				["arifle_MXM_F","30Rnd_65x39_caseless_mag"],
				["arifle_SDAR_F","20Rnd_556x45_UW_mag"],
				["arifle_TRG20_F","30Rnd_556x45_Stanag"],
				["m16_EPOCH","30Rnd_556x45_Stanag"],
				["m16Red_EPOCH","30Rnd_556x45_Stanag"],
				["M14_EPOCH","20Rnd_762x51_Mag"],
				["M14Grn_EPOCH","20Rnd_762x51_Mag"],
				["m4a3_EPOCH","30Rnd_556x45_Stanag"],
				["SMG_02_F","30Rnd_9x21_Mag"],
				["SMG_01_F","30Rnd_45ACP_Mag_SMG_01"],
				["Hgun_PDW2000_F","30Rnd_9x21_Mag"],
				["M14_EPOCH","20Rnd_762x51_Mag"],
				["M14Grn_EPOCH","20Rnd_762x51_Mag"],
				["arifle_MXM_F","30Rnd_65x39_caseless_mag_Tracer"],
				["arifle_MXM_Black_F","30Rnd_65x39_caseless_mag_Tracer"],
				["srifle_DMR_01_F","10Rnd_762x54_Mag"],
				["srifle_EBR_F","20Rnd_762x51_Mag"],
				["Arifle_MX_SW_F","100Rnd_65x39_caseless_mag_Tracer"],
				["Arifle_MX_SW_Black_F","100Rnd_65x39_caseless_mag_Tracer"]
			*/
			],
			[//Magazines
			/*
				["3rnd_HE_Grenade_Shell",1,2],
				["30Rnd_65x39_caseless_green",3,6],
				["30Rnd_556x45_Stanag",3,6],
				["30Rnd_556x45_Stanag",3,6],
				["30Rnd_45ACP_Mag_SMG_01",3,6],
				["20Rnd_556x45_UW_mag",3,6],
				["20Rnd_762x51_Mag",3,10],
				["200Rnd_65x39_cased_Box",3,6],
				["100Rnd_65x39_caseless_mag_Tracer",3,6],
				["3rnd_HE_Grenade_Shell",1,4],
				["HandGrenade",1,3],
				["EnergyPack",2,5]
			*/
			],
			[  // Optics
			/*
				["optic_Aco",1,3],["optic_ACO_grn",1,3],["optic_Aco_smg",1,3],["optic_ACO_grn_smg",1,3],["optic_Holosight",1,3],["optic_Holosight_smg",1,3],
				["optic_Arco",1,3],["optic_Hamr",1,3],["optic_MRCO",1,3],["optic_Yorris",1,3],["optic_MRD",1,3],["acc_flashlight",1,3]
			*/
			],
			[
				["jerrycan_epoch",1,2],
				["lighter_epoch",1,2],
				["CircuitParts",2,3],
				["WoodLog_EPOCH",5,10],
				["ItemCorrugated",3,10],
				["ItemMixOil",1,2],
				["MortarBucket",5,10],
				["PartPlankPack",10,19],
				["ItemLockbox",1,2],
				["ItemCables",1,2],
				["ItemBattery",1,2],
				["Pelt_EPOCH",1,2],
				["ItemCopperBar",1,3],
				["ItemGoldBar",1,3],
				["ItemAluminumBar",1,3],
				["ItemTinBar",1,3],
				["ItemCanvas",2,4],
				["ItemKiloHemp",1,3],
				["ItemRope",1,3],
				["ItemBurlap",1,3],
				["ItemCanvas",1,3],
				["ItemCorrugated",1,3],
				["EngineParts",1,3],
				["FuelTank",1,3],
				["SpareTire",2,4],
				["ItemRotor",1,2],
				["EngineBlock",1,2],
				["ItemDuctTape",1,3]
			],
			[//Items
				["FAK",1,5],["VehicleRepair",1,5],
				["ItemSodaRbull",1,3],["ItemSodaOrangeSherbet",1,3],["ItemSodaPurple",1,3],["ItemSodaMocha",1,3],["ItemSodaBurst",1,3],
				["CookedChicken_EPOCH",1,3],["CookedGoat_EPOCH",1,3],["CookedSheep_EPOCH",1,3],["FoodSnooter",1,3],["FoodMeeps",1,3],["FoodBioMeat",1,3],["ItemTuna",1,3],["ItemSeaBass",1,3],["ItemTrout",1,3],
				"FAK" , "Towelette" , "ItemVitamins",
				"ItemCanteen_Empty", "ItemCanteen_Clean", "ItemBottlePlastic_Empty", 
				"ItemBottlePlastic_Clean", "ItemWaterPurificationTablets", "ItemPainKillers"
			],
			[ // Backpacks
				["B_AssaultPack_dgtl",0,2],["B_AssaultPack_khk",0,2],["B_AssaultPack_mcamo",0,2],["B_AssaultPack_ocamo",0,2],["B_AssaultPack_rgr",0,2],["B_AssaultPack_sgg",0,2],
				["B_FieldPack_cbr",0,2],["B_FieldPack_khk",0,2],["B_FieldPack_ocamo",0,2],["B_FieldPack_oli",0,2],["B_FieldPack_oucamo",0,2],
				["smallbackpack_red_epoch",0,2],["smallbackpack_green_epoch",0,2],["smallbackpack_teal_epoch",0,2],["smallbackpack_pink_epoch",0,2]
			]
		];

	blck_BoxLoot_Red = 
		//[Medium]
		[
			[// Weapons
			/*
				["MultiGun","EnergyPackLg"],
				["arifle_Katiba_F","30Rnd_65x39_caseless_green"],
				["arifle_Katiba_GL_F","30Rnd_65x39_caseless_green"],
				["arifle_Mk20_F","30Rnd_556x45_Stanag"],
				["arifle_Mk20_plain_F","30Rnd_556x45_Stanag"],
				["arifle_Mk20C_F","30Rnd_556x45_Stanag"],
				["arifle_Mk20_GL_F","30Rnd_556x45_Stanag"],
				["arifle_Mk20_GL_plain_F","30Rnd_556x45_Stanag"],
				["arifle_MX_F","30Rnd_65x39_caseless_mag"],
				["arifle_MX_GL_F","30Rnd_65x39_caseless_mag"],
				//["arifle_MX_SW_Black_Hamr_pointer_F","100Rnd_65x39_caseless_mag_Tracer"],
				["arifle_MXC_F","30Rnd_65x39_caseless_mag"],
				["arifle_MXM_F","30Rnd_65x39_caseless_mag"],
				["arifle_TRG20_F","30Rnd_556x45_Stanag"],
				["m16_EPOCH","30Rnd_556x45_Stanag"],
				["m16Red_EPOCH","30Rnd_556x45_Stanag"],
				["M14_EPOCH","20Rnd_762x51_Mag"],
				["M14Grn_EPOCH","20Rnd_762x51_Mag"],
				["m4a3_EPOCH","30Rnd_556x45_Stanag"],
				["SMG_02_F","30Rnd_9x21_Mag"],
				["SMG_01_F","30Rnd_45ACP_Mag_SMG_01"],
				["Hgun_PDW2000_F","30Rnd_9x21_Mag"],
				["M14_EPOCH","20Rnd_762x51_Mag"],
				["M14Grn_EPOCH","20Rnd_762x51_Mag"],
				["arifle_MXM_F","30Rnd_65x39_caseless_mag_Tracer"],
				["arifle_MXM_Black_F","30Rnd_65x39_caseless_mag_Tracer"],
				["srifle_DMR_01_F","10Rnd_762x54_Mag"],
				["srifle_LRR_F","7Rnd_408_Mag"],
				["srifle_EBR_F","20Rnd_762x51_Mag"],
				["m249_EPOCH","200Rnd_556x45_M249"],
				["LMG_Zafir_F","150Rnd_762x54_Box"]
				*/
			],
			[//Magazines
				/*
				["3rnd_HE_Grenade_Shell",1,5],["30Rnd_65x39_caseless_green",3,6],["30Rnd_556x45_Stanag",3,6],["30Rnd_556x45_Stanag",3,6],["30Rnd_45ACP_Mag_SMG_01",3,6],["20Rnd_556x45_UW_mag",3,6],
				["10Rnd_762x54_Mag",3,6],["20Rnd_762x51_Mag",3,7],["200Rnd_65x39_cased_Box",3,6],["100Rnd_65x39_caseless_mag_Tracer",3,6],
				["3rnd_HE_Grenade_Shell",1,2],["HandGrenade",1,3],["EnergyPack",2,5]
				*/
			],
			[  // Optics
				/*
				["optic_Aco",1,3],["optic_ACO_grn",1,3],["optic_Aco_smg",1,3],["optic_ACO_grn_smg",1,3],
				["optic_Holosight",1,3],["optic_Holosight_smg",1,3],["optic_Yorris",1,3],["optic_MRD",1,3],["acc_flashlight",1,3],
				["muzzle_snds_H",1,3],["muzzle_snds_L",1,3],["muzzle_snds_M",1,3],["muzzle_snds_B",1,3],["muzzle_snds_H_MG",1,3],["muzzle_snds_acp",1,3]
				*/
			],
			[
				["jerrycan_epoch",1,2],
				["lighter_epoch",1,2],
				["CircuitParts",2,3],
				["WoodLog_EPOCH",5,10],
				["ItemCorrugated",3,10],
				["ItemMixOil",1,2],
				["MortarBucket",5,10],
				["PartPlankPack",10,19],
				["ItemLockbox",1,2],
				["ItemSolar",1,2],
				["ItemCables",1,2],
				["ItemBattery",1,2],
				["Pelt_EPOCH",1,2],
				["ItemCopperBar",1,3],
				["ItemGoldBar",1,3],
				["ItemAluminumBar",1,3],
				["ItemTinBar",1,3],
				["ItemCanvas",2,4],
				["ItemKiloHemp",1,3],
				["ItemRope",1,3],
				["ItemBurlap",1,3],
				["ItemCanvas",1,3],
				["ItemCorrugated",1,3],
				["EngineParts",1,3],
				["FuelTank",1,3],
				["SpareTire",2,4],
				["ItemRotor",1,2],
				["EngineBlock",1,2],
				["ItemDuctTape",1,3]
			],
			[//Items
				["Heal_EPOCH",1,2],["Defib_EPOCH",1,2],["Repair_EPOCH",1,2],["FAK",1,2],["VehicleRepair",1,3],
				["ItemSodaRbull",1,3],["ItemSodaOrangeSherbet",1,3],["ItemSodaPurple",1,3],["ItemSodaMocha",1,3],["ItemSodaBurst",1,3],["ItemSodaAlpineDude",1,3],
				["CookedChicken_EPOCH",1,3],["CookedGoat_EPOCH",1,3],["CookedSheep_EPOCH",1,3],
				["FoodSnooter",1,3],["FoodMeeps",1,3],["FoodBioMeat",1,3],["ItemTuna",1,3],["ItemSeaBass",1,3],["ItemTrout",1,3],["ItemPowderMilk",1,3],["ItemRicebox",1,3],
				["ItemCereals",1,3],["krypto_candy_epoch",1,3],["ItemBakedBeans",1,3],["HotAxeSauce_epoch",1,3],
				"FAK" , "Towelette" , "ItemVitamins", "morphine_epoch", "ItemCanteen_Empty", "ItemCanteen_Clean", "ItemBottlePlastic_Empty", 
				"ItemBottlePlastic_Clean", "ItemWaterPurificationTablets", "ItemPainKillers"
			],
			[ // Backpacks
				["B_AssaultPack_dgtl",0,2],["B_AssaultPack_khk",0,2],["B_AssaultPack_mcamo",0,2],["B_AssaultPack_ocamo",0,2],["B_AssaultPack_rgr",0,2],["B_AssaultPack_sgg",0,2],
				["smallbackpack_red_epoch",0,2],["smallbackpack_green_epoch",0,2],["smallbackpack_teal_epoch",0,2],["smallbackpack_pink_epoch",0,2]
			]
		];

blck_contructionLoot = blck_BoxLoot_Green;
blck_highPoweredLoot = blck_BoxLoot_Orange;
blck_supportLoot = blck_BoxLoot_Green;


blck_crateTypes = ["Box_FIA_Ammo_F","Box_FIA_Support_F","Box_FIA_Wps_F","I_SupplyCrate_F","Box_NATO_AmmoVeh_F","Box_East_AmmoVeh_F","IG_supplyCrate_F","Box_NATO_Wps_F","I_CargoNet_01_ammo_F","O_CargoNet_01_ammo_F","B_CargoNet_01_ammo_F"];  // Default crate type.

diag_log "[blckeagls] Configurations for Epoch Loaded";

