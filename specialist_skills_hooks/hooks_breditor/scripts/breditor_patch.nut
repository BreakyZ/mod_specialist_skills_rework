::Mod_Sellswords.HooksMod.hook("scripts/ui/screens/world/world_breditor_screen", function( q ) {

	q.gimmeperks = @(__original) function()
	{
		local ret = __original();
		ret.Class <- clone this.Const.Perks.Class.Tree;

		return ret;
	}

});