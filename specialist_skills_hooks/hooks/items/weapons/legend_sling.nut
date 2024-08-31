::ModSpecialistSkillsRework.HooksMod.hook("scripts/items/weapons/legend_sling", function( q )
{	
	q.create = @(__original) function()
	{
		__original();

		this.m.RangeMax = 6;
		this.m.RangeIdeal = 6;
	}
});