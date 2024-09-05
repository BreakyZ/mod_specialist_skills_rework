::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/deathblow_skill", function( q ) 
{	
	q.m.IsHidden = true;
	q.getTooltip = @(__original) function()
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local ret = this.getDefaultTooltip();

		if (actor.getFlags().has("knifeSpecialist") && (item.getID() == "weapon.qatal_dagger" || item.getID() == "weapon.named_qatal_dagger"))
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]50%[/color] more damage against and ignores additional [color=" + this.Const.UI.Color.DamageValue + "]30%[/color] armor of targets that have the Dazed, Stunned, Sleeping, Rooted, Distracted, Trapped in Web or Trapped in Net status effects."
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]33%[/color] more damage against and ignores additional [color=" + this.Const.UI.Color.DamageValue + "]20%[/color] armor of targets that have the Dazed, Stunned, Sleeping, Rooted, Distracted, Trapped in Web or Trapped in Net status effects."
			});
		}
		return ret;
	}

	q.isHidden <- function()
	{
		local actor = this.getContainer().getActor();		
		local item = actor.getMainhandItem();

		switch (true)
		{
			case item == null:
				return true;
			case item.getID() == "weapon.qatal_dagger" || item.getID() == "weapon.named_qatal_dagger":
				return false;
			case actor.getFlags().has("knifeSpecialist") && item.isWeaponType(this.Const.Items.WeaponType.Dagger):
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
		local item = actor.getMainhandItem();
		local targetStatus = _targetEntity.getSkills();

		if (_skill == this && (targetStatus.hasSkill("effects.dazed") || targetStatus.hasSkill("effects.stunned") || targetStatus.hasSkill("effects.sleeping") || targetStatus.hasSkill("effects.net") || targetStatus.hasSkill("effects.distracted") || targetStatus.hasSkill("effects.web") || targetStatus.hasSkill("effects.rooted") || targetStatus.hasSkill("effects.legend_grappled") || targetStatus.hasSkill("effects.shellshocked") || targetStatus.hasSkill("effects.chilled") || targetStatus.hasSkill("effects.staggered")))
		{
			if (actor.getFlags().has("knifeSpecialist") && (item.getID() == "weapon.qatal_dagger" || item.getID() == "weapon.named_qatal_dagger"))
			{
				_properties.DamageTotalMult *= 1.5;
				_properties.DamageDirectAdd += 0.3;
			}
			else
			{
				_properties.DamageTotalMult *= 1.33;
				_properties.DamageDirectAdd += 0.2;
			}
		}
	}
});
