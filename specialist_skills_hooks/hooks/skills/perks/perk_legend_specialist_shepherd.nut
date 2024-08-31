::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_sling_skill", function ( q )
{
	q.m.armorDamageApplied <- 0;
	q.m.minDamageApplied <- 0;
	q.m.maxDamageApplied <- 0;

	q.create = @(__original) function()
	{
		__original();
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	q.getDescription <- function()
	{
		return "Slinger? I hardly knew \'er!";
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
			case !item.isWeaponType(this.Const.Items.WeaponType.Sling):
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "This character is not using the specialist weapon or hasn\'t accumulated a bonus yet"
				});
				return tooltip;
			}
			case item.getID() == "weapon.legend_sling" || item.getID() == "weapon.legend_slingshot":
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
			if (item.getID() == "weapon.legend_sling" || item.getID() == "weapon.legend_slingstaff" || item.getID() == "weapon.named_sling")
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/armor_damage.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + actor.calculateSpecialistBonus(25, specialistWeapon) + "%[/color] damage to armor"
				});
			}
			if (actor.getCurrentProperties().IsSpecializedInSlings)
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
			case !item.isWeaponType(this.Const.Items.WeaponType.Sling):
				return;
			case item.getID() == "weapon.legend_sling" || item.getID() == "weapon.legend_slingshot":
				specialistWeapon = true;
		}
		_properties.RangedSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		this.m.armorDamageApplied = 0.01 * actor.calculateSpecialistBonus(25, specialistWeapon)

		if (actor.getCurrentProperties().IsSpecializedInSlings)
		{
			this.m.minDamageApplied = actor.calculateSpecialistBonus(6, specialistWeapon);
			this.m.maxDamageApplied = actor.calculateSpecialistBonus(16, specialistWeapon);
			_properties.DamageRegularMin += this.m.minDamageApplied;
			_properties.DamageRegularMax += this.m.maxDamageApplied;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{	
		local actor = this.getContainer().getActor();
		if (_skill.getID() == "actives.legend_slingstaff_bash" && actor.getCurrentProperties().IsSpecializedInSlings)
		{
			_properties.DamageRegularMin -= this.m.minDamageApplied;
			_properties.DamageRegularMax -= this.m.maxDamageApplied;
		}
		if (_skill.getID() == "actives.legend_sling_heavy_stone")
		{
			_properties.DamageArmorMult += this.m.armorDamageApplied;
		}
	}
});
