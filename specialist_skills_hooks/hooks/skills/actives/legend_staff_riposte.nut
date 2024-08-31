::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/legend_staff_riposte", function ( q )
{
	q.m.IsHidden = true;
	q.isUsable = @(__original) function()
	{
		return !this.m.IsSpent && this.skill.isUsable() && !this.getContainer().hasSkill("effects.riposte") && this.getContainer().getActor().getSkills().hasSkill("perk.legend_staff_block");
	}

	q.isHidden <- function()
	{
		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_staff_block"))
			return false;
		return this.skill.isHidden();
	}
});
