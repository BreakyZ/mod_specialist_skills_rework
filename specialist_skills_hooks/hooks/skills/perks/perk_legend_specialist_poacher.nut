::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_shortbow_skill", function ( q )
{
	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/perks/perk_spec_shortbow.png";
		// this.m.IconMini = "perk_spec_shortbow_mini.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	q.getDescription <- function()
	{
		return this.getDefaultSpecialistSkillDescription("Bows");
	}

	q.specialistWeaponTooltip <- function (_specialistWeapon = false)
	{
		local actor = this.getContainer().getActor();
		if (actor.calculateSpecialistBonus(12, _specialistWeapon) == 0)
			return this.getNoSpecialistWeaponTooltip();

		local item = actor.getMainhandItem();
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, _specialistWeapon) + "[/color] Ranged Skill"
		});
		if (actor.getCurrentProperties().IsSpecializedInBows)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(6, _specialistWeapon) + "-" + actor.calculateSpecialistBonus(16, _specialistWeapon) + "[/color] Damage"
			});
		}
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Doubles these bonuses, but removes the bonus Armor Penetration when fighting Beasts"
		});
		return tooltip;
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
			case !item.isWeaponType(this.Const.Items.WeaponType.Bow):
				return this.getNoSpecialistWeaponTooltip();
			case item.getID() == "weapon.wonky_bow" || item.getID() == "weapon.short_bow":
				specialistWeapon = true;
		}

		return this.specialistWeaponTooltip(specialistWeapon);
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
			case !item.isWeaponType(this.Const.Items.WeaponType.Bow):
				return;
			case item.getID() == "weapon.wonky_bow" || item.getID() == "weapon.short_bow":
				specialistWeapon = true;
		}

		_properties.RangedSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		_properties.DamageDirectAdd += 0.01 * actor.calculateSpecialistBonus(25, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInBows)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}

	q.validTarget <- function( _targetID)
	{
		if (_targetID == this.Const.EntityType.Wolf || _targetID == this.Const.EntityType.Spider || _targetID == this.Const.EntityType.Hyena)
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
		if (item == null || !item.isWeaponType(this.Const.Items.WeaponType.Bow))
		{
			return;
		}

		if (item.isWeaponType(this.Const.Items.ItemType.Shortbow))
		{
			specialistWeapon = true;
		}
		
		if (this.validTarget(_targetEntity.getType()))
		{
			_properties.RangedSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
			_properties.DamageDirectAdd -= 0.01 * actor.calculateSpecialistBonus(25, specialistWeapon);

			if (actor.getCurrentProperties().IsSpecializedInCrossbows)
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
