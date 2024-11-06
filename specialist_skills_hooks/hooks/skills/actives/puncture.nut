::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/puncture", function( q ) 
{
	q.getHitChance = @(__original) function (_targetEntity)
	{
		if (_targetEntity == null)
		{
			return 0;
		}
		local mod = 0;
		if (_targetEntity.getSkills().hasSkill("effects.debilitated"))
		{
			mod += 10;
		}
		if (_targetEntity.getSkills().hasSkill("effects.distracted"))
		{
			mod += 10;
		}
		if (_targetEntity.getSkills().hasSkill("effects.legend_baffled"))
		{
			mod += 10;
		}
		if (_targetEntity.getSkills().hasSkill("effects.legend_dazed"))
		{
			mod += 10;
		}
		if (_targetEntity.getSkills().hasSkill("effects.legend_parried"))
		{
			mod += 10;
		}
		if (_targetEntity.getSkills().hasSkill("effects.legend_grappled"))
		{
			mod += 10;
		}
		if (_targetEntity.getSkills().hasSkill("effects.staggered"))
		{
			mod += 10;
		}
		if (_targetEntity.getSkills().hasSkill("effects.shellshocked"))
		{
			mod += 10;
		}
		if (_targetEntity.getSkills().hasSkill("effects.net"))
		{
			mod += 25;
		}
		if (_targetEntity.getSkills().hasSkill("effects.web"))
		{
			mod += 25;
		}
		if (_targetEntity.getSkills().hasSkill("effects.stunned"))
		{
			mod += 25;
		}
		if (_targetEntity.getSkills().hasSkill("effects.legend_tackled"))
		{
			mod += 50;
		}
		if (_targetEntity.getSkills().hasSkill("effects.sleeping"))
		{
			mod += 50;
		}
		if (_targetEntity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			mod += 50;
		}
		local chance = (1.0 - _targetEntity.getFatiguePct()) * 50;
		return mod - this.Math.round(chance);
	}
});