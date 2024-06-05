this.perk_specialist_inventor <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.specialist_inventor";
		this.m.Name = this.Const.Strings.PerkName.SpecialistInventor;
		this.m.Description = this.Const.Strings.PerkDescription.SpecialistInventor;
		this.m.Icon = "ui/perks/specialist_inventor.png";
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
			case item.isWeaponType(this.Const.Items.WeaponType.Spear) && item.isWeaponType(this.Const.Items.WeaponType.Firearm):
				return handleSpears( _properties );
			case !(item.isWeaponType(this.Const.Items.WeaponType.Firearm) || item.isWeaponType(this.Const.Items.WeaponType.Crossbow)):
				return;
			case item.isWeaponType(this.Const.Items.WeaponType.Firearm):
				specialistWeapon = true;
		}

		_properties.RangedSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInCrossbows)
		{
			actor.isInventorSpecialist = true;

			// might be this or something different
			// if (!this.m.Container.hasSkill("actives.launch_fire_bomb_skill"))
			// {
			// 	this.m.Container.add(this.new("scripts/skills/actives/launch_fire_bomb_skill"));
			// }
		}
	}

	function handleSpears( _properties )
	{	
		local actor = this.getContainer().getActor();
		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, true);

		if (actor.getCurrentProperties().IsSpecializedInSpears)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, true);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, true);
		}
	}
});
