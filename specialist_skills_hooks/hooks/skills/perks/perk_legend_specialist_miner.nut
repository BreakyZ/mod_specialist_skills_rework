::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_pickaxe_skill", function ( q )
{
	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/perks/perk_spec_pickaxe.png";
		// this.m.IconMini = "perk_spec_pickaxe_mini.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	q.getDescription <- function()
	{
		return this.getDefaultSpecialistSkillDescription("Two Handed Hammers");
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
		if (actor.getCurrentProperties().IsSpecializedInHammers)
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
			case !item.isWeaponType(this.Const.Items.WeaponType.Hammer):
				return this.getNoSpecialistWeaponTooltip();
			case (item.getID() == "weapon.pickaxe" || item.getID() == "weapon.military_pick" || item.getID() == "weapon.heavy_mining_pick"):
				return this.specialistWeaponTooltip(true);
			case !item.isItemType(this.Const.Items.ItemType.TwoHanded):
				return this.getNoSpecialistWeaponTooltip();
		}

		return this.specialistWeaponTooltip(false);
	}

	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		switch (true) 
		{
			case item == null:
			case !item.isWeaponType(this.Const.Items.WeaponType.Hammer):
				return;
			case item.getID() == "weapon.pickaxe" || item.getID() == "weapon.military_pick" || item.getID() == "weapon.heavy_mining_pick":
				specialistWeapon = true;
				break;
			case !item.isItemType(this.Const.Items.ItemType.TwoHanded):
				return;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInHammers)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}
});
