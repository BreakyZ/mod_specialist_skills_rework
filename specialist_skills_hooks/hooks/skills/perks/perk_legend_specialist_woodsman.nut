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
		return this.getDefaultSpecialistSkillDescription("Axes");
	}

	q.specialistWeaponTooltip <- function (_specialistWeapon = false)
	{
		local actor = this.getContainer().getActor();
		if (actor.calculateSpecialistBonus(12, _specialistWeapon) == 0)
			return this.getNoSpecialistWeaponTooltip();

		local item = actor.getMainhandItem();
		local tooltip = this.skill.getTooltip();

		if (item.isWeaponType(this.Const.Items.WeaponType.Throwing))
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, _specialistWeapon) + "[/color] Ranged Skill"
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, _specialistWeapon) + "[/color] Melee Skill"
			});
		}
		if (actor.getCurrentProperties().IsSpecializedInAxes)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(6, _specialistWeapon) + "-" + actor.calculateSpecialistBonus(16, _specialistWeapon) + "[/color] Damage"
			});
		}
		return tooltip;
	}

	q.getTooltip <- function()
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		switch (true) 
		{
			case item == null:
				return this.getNoSpecialistWeaponTooltip();
			case item.getID() == "weapon.legend_saw":
			case item.getID() == "weapon.woodcutters_axe":
				return this.specialistWeaponTooltip(true);
			case !item.isWeaponType(this.Const.Items.WeaponType.Axe):
				return this.getNoSpecialistWeaponTooltip();
		}

		return this.specialistWeaponTooltip(false);
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
