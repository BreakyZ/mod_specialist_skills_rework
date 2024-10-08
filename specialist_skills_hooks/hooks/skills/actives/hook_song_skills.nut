::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/legend_drums_of_life_skill", function( q )
{
	q.m.baseEffect <- 1;
	if (::Is_SSU_Exist)
	{
		q.m.specialistEffect <- 3;
		q.m.minnesangerEffect <- 4;
	}
	else
	{
		q.m.specialistEffect <- 1;
		q.m.minnesangerEffect <- 2;
	}

	q.getDescription <- function()
	{
		local effect = 0;
		effect += this.m.baseEffect;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_specialist_lute_skill"))
			effect += this.m.specialistEffect;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_minnesanger"))
			effect += this.m.minnesangerEffect;

		return "Push allies on with your music, restoring the health of all allies within 8 tiles by [color=" + this.Const.UI.Color.PositiveValue + "]" + effect + "[/color]. Must be holding a musical instrument to use.";
	}

	q.onUse = @(__original) function( _user, _targetTile )
	{

		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());
		local skill = this.new("scripts/skills/effects/legend_drums_of_life_effect");
		local effect = 0;
		local march = null;

		effect += this.m.baseEffect;
		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_specialist_lute_skill"))
			effect += this.m.specialistEffect;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_minnesanger"))
			effect += this.m.minnesangerEffect;
		skill.setEffect(effect);

		if (_user.getSkills().hasSkill("perk.legend_meistersаnger"))
			local march = this.new("scripts/skills/effects/legend_martial_march_effect");

		foreach( a in actors )
		{
			switch (true)
			{
				case a.getID() == _user.getID():
				case a.getFaction() != _user.getFaction():
				case myTile.getDistanceTo(a.getTile()) > 8:
					continue;
				case !a.getSkills().hasSkill("effects.legend_drums_of_life"):
					a.getSkills().add(skill);
				case march == null:
					continue;
				case !a.getSkills().hasSkill("effects.legend_martial_march"):
				{
					a.getSkills().add(march);
					continue;
				}
				case a.getSkills().hasSkill("effects.legend_martial_march"):
				{
					local actor_skill = a.getSkills().getSkillByID("effects.legend_martial_march");
					actor_skill.incrementStacks();
					actor_skill.resetTurnsWithoutSong();
				}
			}
		}

		this.getContainer().add(skill);
		if (march != null && !this.getContainer().hasSkill("effects.legend_martial_march"))
			this.getContainer().add(march);
		if (march != null && a.getSkills().hasSkill("effects.legend_martial_march"))
		{
			local actor_skill = this.getContainer().getSkillByID("effects.legend_martial_march");
			actor_skill.incrementStacks();
			actor_skill.resetTurnsWithoutSong();
		}
		return true;
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/legend_drums_of_war_skill", function( q )
{
	q.m.baseEffect <- 1;
	if (::Is_SSU_Exist)
	{
		q.m.specialistEffect <- 1;
		q.m.minnesangerEffect <- 2;
	}
	else
	{
		q.m.specialistEffect <- 1;
		q.m.minnesangerEffect <- 2;
	}

	q.getDescription <- function()
	{
		local effect = 0;
		effect += this.m.baseEffect;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_specialist_lute_skill"))
			effect += this.m.specialistEffect;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_minnesanger"))
			effect += this.m.minnesangerEffect;

		return "Push allies on with your music, lowering the fatigue of all allies within 8 tiles by [color=" + this.Const.UI.Color.NegativeValue + "]" + effect + "[/color]. Must be holding a musical instrument to use.";
	}

	q.onUse = @(__original) function( _user, _targetTile )
	{

		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());
		local skill = this.new("scripts/skills/effects/legend_drums_of_war_effect");
		local effect = 0;
		local march = null;

		effect += this.m.baseEffect;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_specialist_lute_skill"))
			effect += this.m.specialistEffect;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_minnesanger"))
			effect += this.m.minnesangerEffect;

		if (_user.getSkills().hasSkill("perk.legend_meistersаnger"))
			local march = this.new("scripts/skills/effects/legend_martial_march_effect");

		skill.setEffect(effect);

		foreach( a in actors )
		{
			switch (true)
			{
				case a.getID() == _user.getID():
				case a.getFatigue() == 0:
				case a.getFaction() != _user.getFaction():
				case myTile.getDistanceTo(a.getTile()) > 8:
					continue;
				case !a.getSkills().hasSkill("effects.legend_drums_of_war"):
					a.getSkills().add(skill);
				case march == null:
					continue;
				case !a.getSkills().hasSkill("effects.legend_martial_march"):
				{
					a.getSkills().add(march);
					continue;
				}
				case a.getSkills().hasSkill("effects.legend_martial_march"):
				{
					local actor_skill = a.getSkills().getSkillByID("effects.legend_martial_march");
					actor_skill.incrementStacks();
					actor_skill.resetTurnsWithoutSong();
				}
			}
		}

		this.getContainer().add(skill);
		if (march != null && !this.getContainer().hasSkill("effects.legend_martial_march"))
			this.getContainer().add(march);
		if (march != null && a.getSkills().hasSkill("effects.legend_martial_march"))
		{
			local actor_skill = this.getContainer().getSkillByID("effects.legend_martial_march");
			actor_skill.incrementStacks();
			actor_skill.resetTurnsWithoutSong();
		}
		return true;
	}
});
