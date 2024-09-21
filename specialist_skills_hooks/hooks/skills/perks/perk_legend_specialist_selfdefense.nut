::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_staff_skill", function ( q )
{
	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/perks/perk_spec_staff.png";
		// this.m.IconMini = "perk_spec_staff_mini.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	q.getDescription <- function()
	{
		return "Twist and thrust with your staff to deflect blows and intercept strikes.";
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
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "This character is not using the specialist weapon or hasn\'t accumulated a bonus yet"
				});
				return tooltip;
			}
			case item.isWeaponType(this.Const.Items.WeaponType.Staff) && item.isWeaponType(this.Const.Items.WeaponType.Sling):
			case item.isWeaponType(this.Const.Items.WeaponType.Staff) && item.isWeaponType(this.Const.Items.WeaponType.Sword):
			case item.isWeaponType(this.Const.Items.WeaponType.Musical):
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(8, specialistWeapon) + "[/color] Defense"
				});
				if (actor.getCurrentProperties().IsSpecializedInStaves)
				{
					tooltip.push({
						id = 7,
						type = "text",
						icon = "ui/icons/melee_skill.png",
						text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(6, specialistWeapon) + "[/color] Melee Skill"
					});
				}
			}
			case (!item.isWeaponType(this.Const.Items.WeaponType.Staff)):
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "This character is not using the specialist weapon or hasn\'t accumulated a bonus yet"
				});
				return tooltip;
			case (!item.isWeaponType(this.Const.Items.WeaponType.MagicStaff)):
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
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(16, specialistWeapon) + "[/color] Defense"
			});
			if (actor.getCurrentProperties().IsSpecializedInStaves)
			{
				tooltip.push({
					id = 7,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(16, specialistWeapon) + "[/color] Melee Skill"
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
			case item.isWeaponType(this.Const.Items.WeaponType.Staff) && item.isWeaponType(this.Const.Items.WeaponType.Sling):
			case item.isWeaponType(this.Const.Items.WeaponType.Staff) && item.isWeaponType(this.Const.Items.WeaponType.Sword):
			case item.isWeaponType(this.Const.Items.WeaponType.Musical):
				return handleHybrid( _properties );
			case (!item.isWeaponType(this.Const.Items.WeaponType.Staff)):
				return;
			case (!item.isWeaponType(this.Const.Items.WeaponType.MagicStaff)):
				specialistWeapon = true;
		}

		_properties.MeleeDefense += actor.calculateSpecialistBonus(16, specialistWeapon);
		_properties.RangedDefense += actor.calculateSpecialistBonus(16, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInStaves)
		{
			_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		}
	}

	q.handleHybrid <- function( _properties )
	{
		local actor = this.getContainer().getActor();
		_properties.MeleeDefense += actor.calculateSpecialistBonus(8);
		_properties.RangedDefense += actor.calculateSpecialistBonus(8);
		if (actor.getCurrentProperties().IsSpecializedInStaves)
		{
			_properties.MeleeSkill += actor.calculateSpecialistBonus(6, specialistWeapon);
		}
	}
});
