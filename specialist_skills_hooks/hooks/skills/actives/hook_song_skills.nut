::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/legend_drums_of_life_skill", function( q )
{
	q.m.baseEffect <- 1;
	q.m.specialistEffect <- 1;
	q.m.minnesangerEffect <- 2;

	q.getDescription <- function()
	{
		local effect = 0;
		local effect += this.m.baseEffect;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_specialist_lute_skill"))
			effect += this.m.specialistEffect;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_minnesanger"))
			effect += this.m.minnesangerEffect;

		return format("Push allies on with your music, restoring the health of all allies within 8 tiles by [color=" + this.Const.UI.Color.PositiveValue + "]%s[/color]. Must be holding a musical instrument to use.", effect);
	}

	q.onUse = @(__original) function( _user, _targetTile )
	{

		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());
		local skill = this.new("scripts/skills/effects/drums_of_life");
		local effect = 0;
		local effect += this.m.baseEffect;
		local march = null;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_specialist_lute_skill"))
			effect += this.m.specialistEffect;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_minnesanger"))
			effect += this.m.minnesangerEffect;
		skill.setEffect(effect);

		if (_user.getSkills().hasSkill("perk.legend_meistersinger"))
			local march = this.new("scripts/skills/effects/legends_martial_march");

		foreach( a in actors )
		{
			if (a.getID() == _user.getID())
			{
				continue;
			}

			if (a.getFatigue() == 0)
			{
				continue;
			}

			if (a.getFaction() == _user.getFaction() && !a.getSkills().hasSkill("effects.drums_of_life"))
			{
				a.getSkills().add(skill);
			}

			if (a.getFaction() == _user.getFaction() && march != null && !a.getSkills().hasSkill("effects.legend_martial_march"))
			{ 
				a.getSkills().add(march);
			}
		}

		this.getContainer().add(skill);
		return true;
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/legend_drums_of_war_skill", function( q )
{
	q.m.baseEffect <- 1;
	q.m.specialistEffect <- 1;
	q.m.minnesangerEffect <- 1;

	q.getDescription <- function()
	{
		local effect = 0;
		local effect += this.m.baseEffect;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_specialist_lute_skill"))
			effect += this.m.specialistEffect;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_minnesanger"))
			effect += this.m.minnesangerEffect;

		return format("Push allies on with your music, lowering the fatigue of all allies within 8 tiles by [color=" + this.Const.UI.Color.NegativeValue + "]%s[/color]. Must be holding a musical instrument to use.", effect);
	}

	q.onUse = @(__original) function( _user, _targetTile )
	{

		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());
		local skill = this.new("scripts/skills/effects/drums_of_war");

		local effect = 0;
		local effect += this.m.baseEffect;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_specialist_lute_skill"))
			effect += this.m.specialistEffect;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_minnesanger"))
			effect += this.m.minnesangerEffect;

		skill.setEffect(effect);

		foreach( a in actors )
		{
			if (a.getID() == _user.getID())
			{
				continue;
			}

			if (a.getFatigue() == 0)
			{
				continue;
			}

			if (a.getFaction() == _user.getFaction() && !a.getSkills().hasSkill("effects.drums_of_war"))
			{
				a.getSkills().add(skill);
			}
		}

		this.getContainer().add(skill);
		return true;
	}
});
