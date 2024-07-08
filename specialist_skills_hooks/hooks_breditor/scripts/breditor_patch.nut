::ModSpecialistSkillsRework.HooksMod.hook("scripts/ui/screens/world/world_breditor_screen", function( q ) {

	q.gimmeperks = @(__original) function()
	{
		local ret = __original();
		ret.ClassTrees <- clone this.Const.Perks.ClassTrees.Tree;

		return ret;
	}

});