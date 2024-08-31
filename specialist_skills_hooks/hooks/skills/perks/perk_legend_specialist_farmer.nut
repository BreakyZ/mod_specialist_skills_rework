::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_pitchfork_skill", function ( q )
{
	q.create = @(__original) function()
	{
		__original();
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	q.getDescription <- function()
	{
		return "Years of using farming tools have given you an understanding of how to stab true and slash in smooth strokes.";
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
			case !(item.isWeaponType(this.Const.Items.WeaponType.Polearm) || item.isItemType(this.Const.Items.ItemType.Pitchfork)):
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "This character is not using the specialist weapon or hasn\'t accumulated a bonus yet"
				});
				return tooltip;
			case item.isItemType(this.Const.Items.ItemType.Pitchfork):
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
				id = 6,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + actor.calculateSpecialistBonus(25, specialistWeapon) + "%[/color] Bonus Armor Damage"
			}]);
			if (actor.getCurrentProperties().IsSpecializedInPolearms)
			{
				tooltip.push({
					id = 7,
					type = "text",
					icon = "ui/icons/damage_dealt.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(9, specialistWeapon) + "-" + actor.calculateSpecialistBonus(24, specialistWeapon) + "[/color] Damage"
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
			case !(item.isWeaponType(this.Const.Items.WeaponType.Polearm) || item.isItemType(this.Const.Items.ItemType.Pitchfork)):
				return;
			case item.isItemType(this.Const.Items.ItemType.Pitchfork):
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		_properties.DamageArmorMult += actor.calculateSpecialistBonus(0.25, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInPolearms)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(9, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(24, specialistWeapon);
		}
	}
});
