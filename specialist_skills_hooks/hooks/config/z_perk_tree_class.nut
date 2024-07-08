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
::Const.Perks.StaffTree.Tree[0] = [::Const.Perks.PerkDefs.LegendSpecStaffSkill];
::Const.Perks.StaffTree.Tree[2] = []
::Const.Perks.StaffTree.Tree[3] = [::Const.Perks.PerkDefs.LegendMasteryStaves];

::Const.Perks.SlingTree.Tree[4] = [];

::Const.Perks.SpecialistInventorTree <- {
	ID = "SpecialistInventorTree",
	Name = "Specialist Inventor",
	Descriptions = [
		"inventor"
	],
	Tree = [
		[::Const.Perks.PerkDefs.SpecialistInventor],
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
		[::Const.Perks.PerkDefs.SpecialistBodyguard],
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
		[::Const.Perks.PerkDefs.SpecialistInquisition],
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
		[::Const.Perks.PerkDefs.SpecialistClub],
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
	::Const.Perks.SpecialistInventorTree		
]