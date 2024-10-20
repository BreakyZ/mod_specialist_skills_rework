::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_sickle_skill", function ( q )
{
	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/perks/perk_spec_sickle.png";
		// this.m.IconMini = "perk_spec_sickle_mini.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	q.getDescription <- function()
	{
		return this.getDefaultSpecialistSkillDescription("One Handed Swords");
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
			icon = "ui/icons/melee_skill.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, _specialistWeapon) + "[/color] Melee Skill"
		});
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/direct_damage.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + actor.calculateSpecialistBonus(25, _specialistWeapon) + "%[/color] of any damage ignores armor"
		});
		if (actor.getCurrentProperties().IsSpecializedInSwords)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(6, _specialistWeapon) + "-" + actor.calculateSpecialistBonus(16, _specialistWeapon) + "[/color] Damage"
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
			case !item.isItemType(this.Const.Items.ItemType.OneHanded):
			case !item.isWeaponType(this.Const.Items.WeaponType.Sword):
				return this.getNoSpecialistWeaponTooltip();
			case item.getID() == "weapon.sickle" || item.getID() == "weapon.goblin_notched_blade"  || item.getID() == "weapon.legend_named_sickle":
				specialistWeapon = true;
		}
		return this.specialistWeaponTooltip(specialistWeapon);
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
			case !item.isItemType(this.Const.Items.ItemType.OneHanded):
				return;
			case !item.isWeaponType(this.Const.Items.WeaponType.Sword):
				return;
			case item.getID() == "weapon.sickle" || item.getID() == "weapon.goblin_notched_blade"  || item.getID() == "weapon.legend_named_sickle":
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		_properties.DamageDirectMult += 0.01 * actor.calculateSpecialistBonus(25, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInSwords)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}
});
