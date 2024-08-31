this.perk_legend_specialist_bodyguard <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_bodyguard";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistBodyguard;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistBodyguard;
		this.m.Icon = "ui/perks/favoured_knight_01.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return "Eating and sleeping with your blade has turned it into an extension of your arm.";
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;
		switch (true) 
		{
			case item == null:
			case !item.isItemType(this.Const.Items.ItemType.TwoHanded):
			case !item.isWeaponType(this.Const.Items.WeaponType.Sword):
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "This character is not using the specialist weapon or hasn\'t accumulated a bonus yet"
				});
				return tooltip;
			}
			case item.getID() == "weapon.legend_longsword":
			case item.getID() == "weapon.legend_named_longsword":
			case item.getID() == "weapon.longsword":
			case item.getID() == "weapon.named_longsword":
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
			tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, specialistWeapon) + "[/color] Melee Skill"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "[color=" + this.Const.UI.Color.DamageValue + "]" + actor.calculateSpecialistBonus(10, specialistWeapon) + "%[/color] Armor Damage"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.DamageValue + "]" + actor.calculateSpecialistBonus(10, specialistWeapon) + "%[/color] Armor Penetration"
			}]);
			if (actor.getCurrentProperties().IsSpecializedInGreatSwords)
			{
				tooltip.push({
					id = 9,
					type = "text",
					icon = "ui/icons/damage_dealt.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(6, specialistWeapon) + "-" + actor.calculateSpecialistBonus(16, specialistWeapon) + "[/color] Damage"
				});
			}

		}

		return tooltip;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;

		switch (true) 
		{
			case item == null:
			case !item.isItemType(this.Const.Items.ItemType.TwoHanded):
			case !item.isWeaponType(this.Const.Items.WeaponType.Sword):
				return;
			case item.getID() == "weapon.legend_longsword":
			case item.getID() == "weapon.legend_named_longsword":
			case item.getID() == "weapon.longsword":
			case item.getID() == "weapon.named_longsword":
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		_properties.DamageDirectMult += 0.01 * actor.calculateSpecialistBonus(10, specialistWeapon);
		_properties.DamageArmorMult += 0.01 * actor.calculateSpecialistBonus(10, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInGreatSwords)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}
});
