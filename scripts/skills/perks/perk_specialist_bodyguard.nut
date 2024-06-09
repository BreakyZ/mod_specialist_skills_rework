this.perk_specialist_bodyguard <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.specialist_bodyguard";
		this.m.Name = this.Const.Strings.PerkName.SpecialistBodyguard;
		this.m.Description = this.Const.Strings.PerkDescription.SpecialistBodyguard;
		this.m.Icon = "ui/perks/favoured_knight_01.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		switch (true) 
		{
			case item == null:
				return;
			case !item.isItemType(this.Const.Items.ItemType.TwoHanded):
				return;
			case !item.isWeaponType(this.Const.Items.WeaponType.Sword):
				return;
			case item.getID() == "weapon.legend_longsword":
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		_properties.DamageDirectMult += 0.01 * actor.calculateSpecialistBonus(10, specialistWeapon);
		_properties.DamageArmorMult += 0.01 * actor.calculateSpecialistBonus(10, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInGreatSwords)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
		else if(::Is_PTR_Exist && actor.getCurrentProperties(IsSpecializedInSwords))
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}
});
