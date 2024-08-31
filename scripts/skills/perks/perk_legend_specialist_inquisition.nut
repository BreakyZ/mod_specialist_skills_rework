this.perk_legend_specialist_inquisition <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_inquisition";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistInquisition;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistInquisition;
		this.m.Icon = "ui/perks/specialist_inquisition.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return "Nobody expects the Inquisition!";
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local off = actor.getOffhandItem(); 
		local specialistWeapon = false;
		switch (true) 
		{
			case item == null:
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "This character is not using the specialist weapon or hasn\'t accumulated a bonus yet"
				});
				return tooltip;
			case item.getID() == "weapon.legend_wooden_stake":
				tooltip.extend([
				{
					id = 6,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, false) + "[/color] Melee Skill"
				},
				{
					id = 7,
					type = "text",
					icon = "ui/icons/damage_dealt.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(10, specialistWeapon) + "[/color] Damage"
				}]);
				return tooltip;
			case !item.isWeaponType(this.Const.Items.WeaponType.Crossbow): 
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "This character is not using the specialist weapon or hasn\'t accumulated a bonus yet"
				});
				return tooltip;
			case (off.getID() == "weapon.legend_hand_crossbow" || item.getID() == "weapon.goblin_crossbow"):
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
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, specialistWeapon) + "[/color] Ranged Skill"
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
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Doubles these bonuses against Alps and Hexe"
			});
		}

		return tooltip;
	}

	function validTarget( _targetID)
	{
		if (_targetID == this.Const.EntityType.Hexe || _targetID == this.Const.EntityType.Alp)
		{
			return true;
		}
		return false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || _skill == null)
			return;

		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local off = actor.getOffhandItem();
		local specialistWeapon = false;

		if (item == null || !item.isWeaponType(this.Const.Items.WeaponType.Crossbow))
			return;

		if (off.getID() == "weapon.legend_hand_crossbow" || item.getID() == "weapon.goblin_crossbow")
		{
			specialistWeapon = true;
		}

		if (_skill.getID() == "actives.shoot_bolt" || _skill.getID() == "actives.shoot_stake" || _skill.getID() == "actives.legend_piercing_bolt")
		{
			if (this.validTarget(_targetEntity.getType()))
			{
				_properties.RangedSkill += actor.calculateSpecialistBonus(24, specialistWeapon);

				if (actor.getCurrentProperties().IsSpecializedInCrossbows)
				{
					_properties.DamageRegularMin += actor.calculateSpecialistBonus(12, specialistWeapon);
					_properties.DamageRegularMax += actor.calculateSpecialistBonus(32, specialistWeapon);
				}
			}
			else
			{
				_properties.RangedSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

				if (actor.getCurrentProperties().IsSpecializedInCrossbows)
				{
					_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
					_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
				}
			}
		}
		if (item.getID() == "weapon.legend_wooden_stake" && (_skill.getID() == "actives.puncture" || _skill.getID() == "actives.legend_wooden_stake_stab"))
		{
			if (this.validTarget(_targetEntity.getType()))
			{
				_properties.MeleeSkill += actor.calculateSpecialistBonus(24, true);
				_properties.DamageRegularMin += actor.calculateSpecialistBonus(20, true);
				_properties.DamageRegularMax += actor.calculateSpecialistBonus(20, true);
			}
			else
			{
				_properties.MeleeSkill += actor.calculateSpecialistBonus(12, true);
				_properties.DamageRegularMin += actor.calculateSpecialistBonus(10, true);
				_properties.DamageRegularMax += actor.calculateSpecialistBonus(10, true);
			}
		}
	}
});
