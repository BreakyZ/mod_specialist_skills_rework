foreach (reload_skill in [
	"reload_bolt",
	"reload_handgonne_skill",
])
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/" + reload_skill, function ( q )
{
	q.onAfterUpdate = @( __original ) function( _properties )
	{
		__original( _properties );
		local actor = this.getContainer().getActor();
		if (actor.getFlags().has("inventorSpecialist"))
		{
			this.m.ActionPointCost -= 1;
		}
	}
});