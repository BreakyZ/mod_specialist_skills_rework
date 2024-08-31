::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_lute_skill", function ( q )
{
	q.create = @(__original) function()
	{
		__original();
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	q.getDescription <- function()
	{
		return "Taverns have taught you that instruments can be used to make spin tunes, bash heads and block a thrown rotten tomato.";
	}

	q.getTooltip <- function()
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;
		if (item == null || !item.isWeaponType(this.Const.Items.WeaponType.Musical))
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "This character is not using the specialist weapon"
			});
			return tooltip;
		}

		
		tooltip.extend([
		{
			id = 6,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Skill"
		},
		{
			id = 6,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Defense"
		},
		{
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increases the effect of Drums of War and Drums of Life by [color=" + this.Const.UI.Color.PositiveValue + "]2[/color]" 
		}]);
		if (actor.getCurrentProperties().IsSpecializedInStaves || actor.getCurrentProperties().IsSpecializedInMaces)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Damage"
			});
		}

		return tooltip;
	}

	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();

		if (item == null || !item.isWeaponType(this.Const.Items.WeaponType.Musical)) return;

		_properties.MeleeSkill += 10;
		_properties.MeleeDefense += 10;

		if (actor.getCurrentProperties().IsSpecializedInStaves || actor.getCurrentProperties().IsSpecializedInMaces)
		{
			_properties.DamageRegularMin += 10;
			_properties.DamageRegularMax += 10;
		}
	}
});
