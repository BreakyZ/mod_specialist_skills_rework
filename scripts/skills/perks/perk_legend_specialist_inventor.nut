this.perk_legend_specialist_inventor <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_inventor";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistInventor;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistInventor;
		this.m.Icon = "ui/perks/specialist_inventor.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return "Using your wits and tools, you\'ve managed to create aids, which help you use unwieldy mechanical weapons with skill and dexterity.";
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;
		local melee = false;
		switch (true) 
		{
			case item == null:
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "This character is not using the specialist weapon or hasn\'t accumulated a bonus yet"
				});
				return tooltip;
			}
			case item.isWeaponType(this.Const.Items.WeaponType.Spear) && item.isWeaponType(this.Const.Items.WeaponType.Firearm):
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, false) + "[/color] Melee Skill"
				});
				if (actor.getCurrentProperties().IsSpecializedInSpears)
				{
					tooltip.push({
						id = 7,
						type = "text",
						icon = "ui/icons/damage_dealt.png",
						text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(6, specialistWeapon) + "-" + actor.calculateSpecialistBonus(16, specialistWeapon) + "[/color] Damage"
					});
				}
			}
			case !(item.isWeaponType(this.Const.Items.WeaponType.Firearm) || item.isWeaponType(this.Const.Items.WeaponType.Crossbow)):
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "This character is not using the specialist weapon or hasn\'t accumulated a bonus yet"
				});
				return tooltip;
			case item.isWeaponType(this.Const.Items.WeaponType.Firearm):
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
			if (actor.getCurrentProperties().IsSpecializedInCrossbows)
			{
				tooltip.push({
					id = 7,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, specialistWeapon) + "[/color] Ranged Skill"
				})
			}
			if (actor.getCurrentProperties().IsSpecializedInCrossbows)
			{
				tooltip.push({
					id = 7,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = "Reduces Reload AP cost for Handgonnes and Crossbows by [color=" + this.Const.UI.Color.NegativeValue + "]1[/color] Minimum Damage Dealt"
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
				return;
			case item.isWeaponType(this.Const.Items.WeaponType.Spear) && item.isWeaponType(this.Const.Items.WeaponType.Firearm):
				return handleSpears( _properties );
			case !(item.isWeaponType(this.Const.Items.WeaponType.Firearm) || item.isWeaponType(this.Const.Items.WeaponType.Crossbow)):
				return;
			case item.isWeaponType(this.Const.Items.WeaponType.Firearm):
				specialistWeapon = true;
		}

		_properties.RangedSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInCrossbows && !actor.getFlags().has("inventorSpecialist"))
		{
			actor.getFlags().add("inventorSpecialist");
		}
	}

	function handleSpears( _properties )
	{	
		local actor = this.getContainer().getActor();
		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, true);

		if (actor.getCurrentProperties().IsSpecializedInSpears)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, true);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, true);
		}
	}
});
