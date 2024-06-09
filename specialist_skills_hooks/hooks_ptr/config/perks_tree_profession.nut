// replaces the damage skills
::Const.Perks.KnifeClassTree.Tree[2] = [];
::Const.Perks.ButcherProfessionTree.Tree[2] = [];
::Const.Perks.BlacksmithProfessionTree.Tree[2] = [];
::Const.Perks.MilitiaProfessionTree.Tree[2] = [];
::Const.Perks.MinerProfessionTree.Tree[2] = [];
::Const.Perks.FarmerProfessionTree.Tree[2] = [];
::Const.Perks.HunterProfessionTree.Tree[2] = [];
::Const.Perks.DiggerProfessionTree.Tree[2] = [];
::Const.Perks.LumberjackProfessionTree.Tree[2] = [];
::Const.Perks.ApothecaryProfessionTree.Tree[2] = [];
::Const.Perks.CultistProfessionTree.Tree[2] = [];
::Const.Perks.MinstrelProfessionTree.Tree[2] = [];
::Const.Perks.ScytheClassTree.Tree[2] = [];

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
