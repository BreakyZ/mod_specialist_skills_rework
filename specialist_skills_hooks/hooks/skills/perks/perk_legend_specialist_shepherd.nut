::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_sling_skill", function ( q )
{
	q.m.armorDamageApplied <- 0;
	q.m.minDamageApplied <- 0;
	q.m.maxDamageApplied <- 0;

	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/perks/perk_spec_sling.png";
		// this.m.IconMini = "perk_spec_sling_mini.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	q.getDescription <- function()
	{
		return this.getDefaultSpecialistSkillDescription("Slings");
	}

	q.specialistWeaponTooltip <- function (_specialistWeapon = false)
	{
		local actor = this.getContainer().getActor();
		if (actor.calculateSpecialistBonus(12, _specialistWeapon) == 0)
			return this.getNoSpecialistWeaponTooltip();

		local item = actor.getMainhandItem();
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, _specialistWeapon) + "[/color] Ranged Skill"
		});
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/armor_damage.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + actor.calculateSpecialistBonus(25, _specialistWeapon) + "%[/color] damage to armor"
		});
		if (actor.getCurrentProperties().IsSpecializedInSlings)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(6, _specialistWeapon) + "-" + actor.calculateSpecialistBonus(16, _specialistWeapon) + "[/color] Damage"
			});
		}
		if (_skill.getID() == "actives.sling_stone" && this.getContainer().hasSkill("effects.legend_slinger_spins"))
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + actor.calculateSpecialistBonus(25, _specialistWeapon) + "%[/color] armor penetration due to Prepare Bullet"
			});
		}
		return tooltip;
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
				return this.getNoSpecialistWeaponTooltip();
			case item.getID() == "weapon.legend_sling" || item.getID() == "weapon.legend_slingshot":
				return this.specialistWeaponTooltip(true);
		}

		return this.specialistWeaponTooltip(false);
	}

	// q.onUpdate = @( __original ) function( _properties )
	// {
	// 	local actor = this.getContainer().getActor();
	// 	local item = actor.getMainhandItem();
	// 	local specialistWeapon = false;

	// 	switch (true) 
	// 	{
	// 		case item == null:
	// 			return;
	// 		case !item.isWeaponType(this.Const.Items.WeaponType.Sling):
	// 			return;
	// 		case item.getID() == "weapon.legend_sling" || item.getID() == "weapon.legend_slingshot":
	// 			specialistWeapon = true;
	// 	}
	// 	_properties.RangedSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
	// 	this.m.armorDamageApplied = 0.01 * actor.calculateSpecialistBonus(25, specialistWeapon)

	// 	if (actor.getCurrentProperties().IsSpecializedInSlings)
	// 	{
	// 		this.m.minDamageApplied = actor.calculateSpecialistBonus(6, specialistWeapon);
	// 		this.m.maxDamageApplied = actor.calculateSpecialistBonus(16, specialistWeapon);
	// 		_properties.DamageRegularMin += this.m.minDamageApplied;
	// 		_properties.DamageRegularMax += this.m.maxDamageApplied;
	// 	}
	// }

	function onAnySkillUsed( _skill, _targetEntity, _properties )
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
		if (_skill.getID() == "actives.legend_sling_heavy_stone" || _skill.getID() == "actives.legend_shoot_stone" || _skill.getID() == "actives.legend_shoot_precise_stone" || _skill.getID() == "actives.sling_stone")
		{
			_properties.RangedSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
			_properties.DamageArmorMult += 0.01 * actor.calculateSpecialistBonus(25, specialistWeapon);
			// if (_skill.getID() == "actives.sling_stone" && this.getContainer().hasSkill("effects.legend_slinger_spins"))
			// 	_properties.DamageDirectAdd += 0.01 * actor.calculateSpecialistBonus(25, specialistWeapon);

			if (actor.getCurrentProperties().IsSpecializedInSlings)
			{
				_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
				_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
			}
		}
	}
});
