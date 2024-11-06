::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/deathblow_skill", function( q ) 
{	
	q.m.IsHidden = true;
	q.m.ApplicableSkills <- 
	[
		"effects.dazed",
		"effects.debilitated",
		"effects.distracted",
		"effects.grappled",
		"effects.net",
		"effects.legend_baffled",
		"effects.legend_choked",
		"effects.legend_tackled",
		"effects.rooted",
		"effects.shellshocked",
		"effects.sleeping",
		"effects.staggered",
		"effects.stunned",
		"effects.web",
	];

	q.getTooltip = @(__original) function()
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local ret = this.getDefaultTooltip();

		if (actor.getFlags().has("knifeSpecialist") && this.setItemHasDeathblow())
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]50%[/color] more damage against and ignores additional [color=" + this.Const.UI.Color.DamageValue + "]30%[/color] armor of targets that have the Dazed, Stunned, Sleeping, Rooted, Distracted, Webbed, Trapped in Net, Staggered, Shellshocked, Tackled, Debilitated or Grappled status effects."
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]33%[/color] more damage against and ignores additional [color=" + this.Const.UI.Color.DamageValue + "]20%[/color] armor of targets that have the Dazed, Stunned, Sleeping, Rooted, Distracted, Webbed, Trapped in Net, Staggered, Shellshocked, Tackled, Debilitated or Grappled status effects."
			});
		}
		return ret;
	}

	q.setItem <- function ( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	q.setItemHasDeathblow <- function()
	{
		foreach (skill in this.m.Item.getSkills())
		{
			if (skill.getID() == "actives.deathblow")
				return true;
		}
		return false;
	}

	q.isHidden <- function()
	{
		local actor = this.getContainer().getActor();

		switch (true)
		{
			case this.m.Item == null:
				return true;
			case this.m.Item.m.hasDeathblow:
				return false;
			case actor.getFlags().has("knifeSpecialist") && this.m.Item.isWeaponType(this.Const.Items.WeaponType.Dagger):
				return false;
		}

		return this.skill.isHidden();
	}

	q.onAnySkillUsed = @(__original) function ( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		local actor = this.getContainer().getActor();
		local targetStatus = _targetEntity.getSkills();

		if (_skill != this) return;

		foreach ( skill in this.m.ApplicableSkills)
		{
			if (targetStatus.hasSkill(skill))
			{
				if (actor.getFlags().has("knifeSpecialist") && this.m.Item.m.hasDeathblow)
				{
					_properties.DamageTotalMult *= 1.5;
					_properties.DamageDirectAdd += 0.3;
					break;
				}
				else
				{
					_properties.DamageTotalMult *= 1.33;
					_properties.DamageDirectAdd += 0.2;
					break;
				}
			}
		}
	}
});
