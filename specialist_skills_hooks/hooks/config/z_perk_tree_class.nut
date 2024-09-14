// replaces the damage skills
::Const.Perks.KnifeClassTree.Tree[2] = [];
::Const.Perks.KnifeClassTree.Tree[3] = [::Const.Perks.PerkDefs.SpecDagger];
::Const.Perks.ButcherClassTree.Tree[2] = [];
::Const.Perks.ButcherClassTree.Tree[3] = [::Const.Perks.PerkDefs.SpecCleaver];
::Const.Perks.HammerClassTree.Tree[2] = [];
::Const.Perks.HammerClassTree.Tree[3] = [::Const.Perks.PerkDefs.SpecHammer];
::Const.Perks.MilitiaClassTree.Tree[2] = [];
::Const.Perks.MilitiaClassTree.Tree[3] = [::Const.Perks.PerkDefs.SpecSpear];
::Const.Perks.PickaxeClassTree.Tree[2] = [];
::Const.Perks.PickaxeClassTree.Tree[3] = [::Const.Perks.PerkDefs.SpecHammer];
::Const.Perks.PitchforkClassTree.Tree[2] = [];
::Const.Perks.PitchforkClassTree.Tree[3] = [::Const.Perks.PerkDefs.SpecCleaver, ::Const.Perks.PerkDefs.SpecPolearm];
::Const.Perks.ShortbowClassTree.Tree[2] = [];
::Const.Perks.ShortbowClassTree.Tree[3] = [::Const.Perks.PerkDefs.SpecBow];
::Const.Perks.ShovelClassTree.Tree[2] = [];
::Const.Perks.ShovelClassTree.Tree[3] = [::Const.Perks.PerkDefs.SpecMace];
::Const.Perks.WoodaxeClassTree.Tree[2] = [];
::Const.Perks.WoodaxeClassTree.Tree[3] = [::Const.Perks.PerkDefs.SpecAxe];
::Const.Perks.SickleClassTree.Tree[2] = [];
::Const.Perks.SickleClassTree.Tree[3] = [::Const.Perks.PerkDefs.SpecSword];
::Const.Perks.NinetailsClassTree.Tree[2] = [];
::Const.Perks.NinetailsClassTree.Tree[3] = [::Const.Perks.PerkDefs.SpecCleaver, ::Const.Perks.PerkDefs.SpecFlail];
::Const.Perks.BardClassTree.Tree[2] = [];
::Const.Perks.BardClassTree.Tree[3] = [::Const.Perks.PerkDefs.LegendMasteryStaves, ::Const.Perks.PerkDefs.SpecMace];
::Const.Perks.ScytheClassTree.Tree[2] = [];
::Const.Perks.ScytheClassTree.Tree[3] = [::Const.Perks.PerkDefs.SpecCleaver, ::Const.Perks.PerkDefs.SpecPolearm];

::Const.Perks.BardClassTree.Tree = 
[
	[
		::Const.Perks.PerkDefs.LegendCheerOn,
		::Const.Perks.PerkDefs.LegendSpecialistLuteSkill
	],
	[::Const.Perks.PerkDefs.LegendDaze],
	[],
	[
		::Const.Perks.PerkDefs.LegendMasteryStaves,
		::Const.Perks.PerkDefs.SpecMace,
		::Const.Perks.PerkDefs.LegendEntice
	],
	[::Const.Perks.PerkDefs.LegendPush],
	[::Const.Perks.PerkDefs.LegendMinnesanger],
	[::Const.Perks.PerkDefs.LegendMeistersanger]
]

::Const.Perks.StaffTree.Tree = 
[
	[],
	[],
	[],
	[::Const.Perks.PerkDefs.LegendMasteryStaves],
	[::Const.Perks.PerkDefs.LegendSpecStaffStun],
	[::Const.Perks.PerkDefs.LegendStaffBlock],
	[]
]

::Const.Perks.SlingTree.Tree = 
[
	[],
	[::Const.Perks.PerkDefs.LegendSlingerSpins],
	[],
	[::Const.Perks.PerkDefs.LegendMasterySlings],
	[],
	[::Const.Perks.PerkDefs.LegendBarrage],
	[]
]

::Const.Perks.SpecialistSlingTree <- {
	ID = "SpecialistSlingTree",
	Name = "Specialist Shepherd",
	Descriptions = [
		"shepherd"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistSlingSkill],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendMasterySlings],
		[],
		[],
		[]
	]
};

::Const.Perks.SpecialistStaffTree <- {
	ID = "SpecialistStaffTree",
	Name = "Specialist Self-Defense",
	Descriptions = [
		"self-defense"
	],
	Tree = [
		[],
		[],
		[::Const.Perks.PerkDefs.LegendSpecStaffSkill],
		[::Const.Perks.PerkDefs.LegendMasteryStaves],
		[],
		[],
		[]
	]
};

::Const.Perks.SpecialistInventorTree <- {
	ID = "SpecialistInventorTree",
	Name = "Specialist Inventor",
	Descriptions = [
		"inventor"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistInventor],
		[],
		[],
		[::Const.Perks.PerkDefs.SpecCrossbow],
		[],
		[],
		[]
	]
};
::Const.Perks.SpecialistBodyguardTree <- {
	ID = "SpecialistBodyguardTree",
	Name = "Specialist Bodyguard",
	Descriptions = [
		"bodyguard"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistBodyguard],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendSpecGreatSword],
		[],
		[],
		[]
	]
};
::Const.Perks.SpecialistInquisitionTree <- {
	ID = "SpecialistInquisitionTree",
	Name = "Specialist Inquisition",
	Descriptions = [
		"inquisition"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistInquisition],
		[],
		[],
		[::Const.Perks.PerkDefs.SpecCrossbow],
		[],
		[],
		[]
	]
};
::Const.Perks.SpecialistClubTree <- {
	ID = "SpecialistBrowbeaterTree",
	Name = "Browbeater Club",
	Descriptions = [
		"browbeater"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpecialistClub],
		[],
		[],
		[::Const.Perks.PerkDefs.SpecMace],
		[],
		[],
		[]
	]
};

::Const.Perks.ClassTrees.Tree = [
	::Const.Perks.BeastClassTree,
	::Const.Perks.BardClassTree,
	::Const.Perks.HealerClassTree,
	::Const.Perks.FaithClassTree,
	::Const.Perks.FistsClassTree,
	::Const.Perks.ChefClassTree,
	::Const.Perks.RepairClassTree,
	::Const.Perks.BarterClassTree,
	::Const.Perks.KnifeClassTree,
	::Const.Perks.ButcherClassTree,
	::Const.Perks.HammerClassTree,
	::Const.Perks.MilitiaClassTree,
	::Const.Perks.PickaxeClassTree,
	::Const.Perks.PitchforkClassTree,
	::Const.Perks.ShortbowClassTree,
	::Const.Perks.WoodaxeClassTree,
	::Const.Perks.SickleClassTree,
	::Const.Perks.NinetailsClassTree,
	::Const.Perks.JugglerClassTree,
	::Const.Perks.HoundmasterClassTree,
	// ::Const.Perks.ScytheClassTree, only for necro origin
	::Const.Perks.SpecialistClubTree,
	::Const.Perks.SpecialistInquisitionTree,
	::Const.Perks.SpecialistBodyguardTree,
	::Const.Perks.SpecialistInventorTree,
	::Const.Perks.SpecialistStaffTree,
	::Const.Perks.SpecialistSlingTree	
]