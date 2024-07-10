this.perk_specialist_club <- this.inherit("scripts/skills/skill", {
	m = {
			Divisible = [100, 80, 60, 40, 20, 0]
		},
	function create()
	{
		this.m.ID = "perk.specialist_club";
		this.m.Name = this.Const.Strings.PerkName.SpecialistClub;
		this.m.Description = this.Const.Strings.PerkDescription.SpecialistClub;
		this.m.Icon = "ui/perks/specialist_club.png";
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
			case !item.isWeaponType(this.Const.Items.WeaponType.Mace):
				return;
			case !item.isItemType(this.Const.Items.ItemType.OneHanded):
				return;
			case item.getID() == "weapon.wooden_stick" || item.getID() == "weapon.bludgeon":
				specialistWeapon = true;
		}

		// please don't tell people i'm a programmer, the damn fatperhit calc are divisible by 5 and i can't round it properly
		local fatPerHit = actor.calculateSpecialistBonus(100, specialistWeapon);
		foreach (num in this.m.Divisible)
		{
			if (fatPerHit >= num)
			{
				_properties.FatigueDealtPerHitMult += 0.01 * fatPerHit;
				break;
			}
		}
		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInMaces)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}
});
