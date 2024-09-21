::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_woodaxe_skill", function ( q )
{
	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/perks/perk_spec_woodsman.png";
		// this.m.IconMini = "perk_spec_woodsman_mini.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	q.getDescription <- function()
	{
		return "Timber!";
	}

	q.getTooltip <- function()
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;
		switch (true) 
		{
			case item == null:
			case !item.isWeaponType(this.Const.Items.WeaponType.Axe) && !item.getID() == "weapon.legend_saw":
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "This character is not using the specialist weapon or hasn\'t accumulated a bonus yet"
				});
				return tooltip;
			}
			case item.getID() == "weapon.woodcutters_axe" || item.getID() == "weapon.legend_saw":
				specialistWeapon = true;
		}

		if (actor.calculateSpecialistBonus(12, specialistWeapon) == 0)
		{
			tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]This character is not using the specialist weapon or hasn\'t accumulated a bonus yet[/color]"
				});
			return tooltip;
		}
		else
		{
			if (item.isWeaponType(this.Const.Items.WeaponType.Throwing))
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, specialistWeapon) + "[/color] Ranged Skill"
				});
			}
			else
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, specialistWeapon) + "[/color] Melee Skill"
				});
			}
			if (actor.getCurrentProperties().IsSpecializedInAxes)
			{
				tooltip.push({
					id = 7,
					type = "text",
					icon = "ui/icons/damage_dealt.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(6, specialistWeapon) + "-" + actor.calculateSpecialistBonus(16, specialistWeapon) + "[/color] Damage"
				});
			}

		}

		return tooltip;
	}

	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;

		switch (true) 
		{
			case item == null:
				return;
			case !item.isWeaponType(this.Const.Items.WeaponType.Axe) && !item.getID() == "weapon.legend_saw":
				return;
			case item.getID() == "weapon.woodcutters_axe" || item.getID() == "weapon.legend_saw":
				specialistWeapon = true;
		}

		if (item.isWeaponType(this.Const.Items.WeaponType.Throwing))
		{
			_properties.RangedSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		}
		else
		{
			_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		}

		if (actor.getCurrentProperties().IsSpecializedInAxes)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}

	q.validTarget <- function( _targetID)
	{
		if (_targetID == this.Const.EntityType.Schrat)
		{
			return true;
		}
		return false;
	}

	q.onAnySkillUsed <- function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;
		if (item == null || (!item.isWeaponType(this.Const.Items.WeaponType.Axe) && !item.getID() == "weapon.legend_saw"))
		{
			return;
		}

		if (item.getID() == "weapon.woodcutters_axe" || item.getID() == "weapon.legend_saw")
		{
			specialistWeapon = true;
		}
		
		if (this.validTarget(_targetEntity.getType()))
		{
			_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

			if (actor.getCurrentProperties().IsSpecializedInAxes)
			{
				_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
				_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
			}
		}
		else
		{
			return;
		}
	}
});
