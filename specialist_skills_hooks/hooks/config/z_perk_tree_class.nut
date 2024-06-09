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
		[::Const.Perks.PerkDefs.SpecSpear, ::Const.Perks.PerkDefs.SpecCrossbow],
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
