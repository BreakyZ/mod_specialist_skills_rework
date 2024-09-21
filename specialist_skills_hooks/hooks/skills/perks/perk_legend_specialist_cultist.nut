::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_ninetails_skill", function ( q )
{
	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/perks/perk_spec_cultist.png";
		// this.m.IconMini = "perk_spec_cultist_mini.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	q.getDescription <- function()
	{
		return "Practice in the arts of punishment makes the tips of the cattail to inflict horrible injuries with greater accuracy.";
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
			case item.getID() == "weapon.orc_flail_2h" || item.getID() == "weapon.named_orc_flail_2h":
			{
				tooltip.extend([{
					id = 6,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(8, false) + "[/color] Melee Skill"
				},
				{
					id = 8,
					type = "text",
					icon = "ui/tooltips/chance_to_hit_head.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(10, false) + "%[/color] Chance to hit Head"
				}]);
				if (actor.getCurrentProperties().IsSpecializedInFlails)
				{
					tooltip.push({
						id = 7,
						type = "text",
						icon = "ui/icons/damage_dealt.png",
						text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(4, specialistWeapon) + "-" + actor.calculateSpecialistBonus(12, specialistWeapon) + "[/color] Damage"
					});
				}
				return tooltip;
			}
			case !item.isItemType(this.Const.Items.ItemType.Cultist):
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "This character is not using the specialist weapon or hasn\'t accumulated a bonus yet"
				});
				return tooltip;
			}
			case item.getID() == "weapon.legend_cat_o_nine_tails":
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
			if (actor.getCurrentProperties().IsSpecializedInFlails || actor.getCurrentProperties().IsSpecializedInCleavers)
			{
				tooltip.extend([{
					id = 7,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, specialistWeapon) + "[/color] Melee Skill"
				},
				{
					id = 8,
					type = "text",
					icon = "ui/tooltips/chance_to_hit_head.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(15, specialistWeapon) + "[/color] Chance to hit Head"
				}]);
			}
			if (actor.getCurrentProperties().IsSpecializedInAxes)
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
				return;
			case item.getID() == "weapon.orc_flail_2h" || item.getID() == "weapon.named_orc_flail_2h":
				return handleNoneCultist();
			case !item.isItemType(this.Const.Items.ItemType.Cultist):
				return;
			case item.getID() == "weapon.legend_cat_o_nine_tails":
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		_properties.HitChance[this.Const.BodyPart.Head] += actor.calculateSpecialistBonus(15, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInFlails)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}

	q.handleNoneCultist <- function( _properties )
	{
		local actor = this.getContainer().getActor();
		_properties.MeleeSkill += actor.calculateSpecialistBonus(8, false);
		_properties.HitChance[this.Const.BodyPart.Head] += actor.calculateSpecialistBonus(10, false);

		if (actor.getCurrentProperties().IsSpecializedInFlails)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(4, false);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(12, false);
		}


	}
});