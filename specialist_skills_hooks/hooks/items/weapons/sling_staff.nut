::ModSpecialistSkillsRework.HooksMod.hook("scripts/items/weapons/legend_sling_staff", function( q )
{	
	q.create = @(__original) function()
	{
		__original();
		this.m.AdditionalAccuracy = -10;
	}
});
