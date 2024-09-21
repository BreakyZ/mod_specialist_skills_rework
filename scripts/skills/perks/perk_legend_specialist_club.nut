this.perk_legend_specialist_club <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_club";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistClub;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistClub;
		this.m.Icon = "ui/perks/perk_spec_mace.png";
		// this.m.IconMini = "perk_spec_mace_mini.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return "Mastering the art of leaning against a wall with a big stick has it\'s benefits.";
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
			case !item.isWeaponType(this.Const.Items.WeaponType.Mace):
			case !item.isItemType(this.Const.Items.ItemType.OneHanded):
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "This character is not using the specialist weapon or hasn\'t accumulated a bonus yet"
				});
				return tooltip;
			}
			case item.getID() == "weapon.wooden_stick" || item.getID() == "weapon.bludgeon":
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
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, specialistWeapon) + "[/color] Melee Skill"
			});
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]5[/color] extra fatigue on hit"
			});
			if (actor.getCurrentProperties().IsSpecializedInCleavers)
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

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		switch (true) 
		{
			case item == null:
			case !item.isWeaponType(this.Const.Items.WeaponType.Mace):
			case !item.isItemType(this.Const.Items.ItemType.OneHanded):
				return;
			case item.getID() == "weapon.wooden_stick" || item.getID() == "weapon.bludgeon":
				specialistWeapon = true;
		}


		_properties.FatigueDealtPerHitMult += 5;
		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInMaces)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}
});
