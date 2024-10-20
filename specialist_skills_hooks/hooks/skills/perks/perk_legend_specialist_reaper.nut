::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_scythe_skill", function ( q )
{
	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/perks/perk_spec_scythe.png";
		// this.m.IconMini = "perk_spec_scythe_mini.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	q.getDescription <- function()
	{
		return this.getDefaultSpecialistSkillDescription("Scythe or Warscythe");
	}

	q.getTooltip <- function()
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;
		if (item == null || !(item.getID() == "weapon.legend_grisly_scythe" || item.getID() == "weapon.legend_scythe" || item.getID() == "weapon.warscythe" || item.getID() == "weapon.named_warscythe"))
			return this.getNoSpecialistWeaponTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] Melee Skill"
		});
		if (actor.getCurrentProperties().IsSpecializedInPolearms || actor.getCurrentProperties().IsSpecializedInCleavers)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10-15[/color] Damage"
			});
		}

		return tooltip;
	}

	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;

		if (item == null || !(item.getID() == "weapon.legend_grisly_scythe" || item.getID() == "weapon.legend_scythe" || item.getID() == "weapon.warscythe" || item.getID() == "weapon.named_warscythe"))
		{
			return;
		}

		_properties.MeleeSkill += 15;

		if (actor.getCurrentProperties().IsSpecializedInPolearms || actor.getCurrentProperties().IsSpecializedInCleavers)
		{
			_properties.DamageRegularMin += 10;
			_properties.DamageRegularMax += 15;
		}
	}
});
