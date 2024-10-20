::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_hammer_skill", function ( q )
{
	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/perks/perk_spec_smith.png";
		// this.m.IconMini = "perk_spec_smith_mini.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	q.getDescription <- function()
	{
		return this.getDefaultSpecialistSkillDescription("One Handed Hammers");
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
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, _specialistWeapon) + "[/color] Melee Skill"
		});
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Receive [color=" + this.Const.UI.Color.PositiveValue + "]+1%[/color] of your current armor and helmet condition as damage to hitpoints, regardless of armor" 
		});
		if (actor.getCurrentProperties().IsSpecializedInSwords)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(6, _specialistWeapon) + "-" + actor.calculateSpecialistBonus(16, _specialistWeapon) + "[/color] Damage"
			});
		}
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
			case !item.isItemType(this.Const.Items.ItemType.OneHanded):
			case !item.isWeaponType(this.Const.Items.WeaponType.Hammer):
				return getNoSpecialistWeaponTooltip();
			case item.getID() == "weapon.legend_hammer":
			case item.getID() == "weapon.legend_named_blacksmith_hammer":
				specialistWeapon = true;
		}

		return specialistWeaponTooltip(specialistWeapon);
	}

	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;

		switch (true) 
		{
			case item == null:
			case !item.isItemType(this.Const.Items.ItemType.OneHanded):
			case !item.isWeaponType(this.Const.Items.WeaponType.Hammer):
				return;
			case item.getID() == "weapon.legend_hammer":
			case item.getID() == "weapon.legend_named_blacksmith_hammer":
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		if (actor.getCurrentProperties().IsSpecializedInHammers && !actor.getFlags().has("blacksmithSpecialist"))
		{
			actor.getFlags().add("blacksmithSpecialist");
		}

		if (actor.getCurrentProperties().IsSpecializedInHammers)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}
});
