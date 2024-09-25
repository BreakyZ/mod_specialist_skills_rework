::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_shovel_skill", function ( q )
{
	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/perks/perk_spec_shovel.png";
		// this.m.IconMini = "perk_spec_shovel_mini.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	q.getDescription <- function()
	{
		return "You used to dig up graves, now you're digging graves.";
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
			case !item.isItemType(this.Const.Items.ItemType.TwoHanded):
			case !item.isWeaponType(this.Const.Items.WeaponType.Mace):
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "This character is not using the specialist weapon or hasn\'t accumulated a bonus yet"
				});
				return tooltip;
			}
			case item.getID() == "weapon.legend_shovel" || item.getID() == "weapon.legend_named_shovel":
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
				icon = "ui/tooltips/special.png",
				text = "Grants the Gravedigging Effect Shovels or Two Handed Maces"
			});
			if (actor.getCurrentProperties().IsSpecializedInMaces)
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
				return this.skill.onRemoved();
			case !item.isItemType(this.Const.Items.ItemType.TwoHanded):
				return this.skill.onRemoved();
			case !item.isWeaponType(this.Const.Items.WeaponType.Mace):
				return this.skill.onRemoved();
			case item.getID() == "weapon.legend_shovel" || item.getID() == "weapon.legend_named_shovel":
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInMaces)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}

	q.onAdded = @( __original ) function()
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();

		if (item != null && (item.getID() == "weapon.legend_shovel" || item.getID() == "weapon.legend_named_shovel") && !actor.getSkills().hasSkill("actives.knock_out"))
		{
			item.addSkill(this.new("scripts/skills/actives/knock_out"));
		}
		if (item != null && item.isWeaponType(this.Const.Items.WeaponType.Mace) && item.isItemType(this.Const.Items.ItemType.TwoHanded) && !actor.getSkills().hasSkill("effects.legend_gravedigging"))
		{
			actor.getSkills().add(this.new("scripts/skills/effects/legend_gravedigging_effect"));
		}
	}

	q.onRemoved = @( __original ) function()
	{
		this.getContainer().getActor().getSkills().removeByID("actives.knock_out");
		this.getContainer().getActor().getSkills().removeByID("effects.legend_gravedigging");
	}
});
