this.perk_specialist_inquisition <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.specialist_inquisition";
		this.m.Name = this.Const.Strings.PerkName.SpecialistInquisition;
		this.m.Description = this.Const.Strings.PerkDescription.SpecialistInquisition;
		this.m.Icon = "ui/perks/specialist_inquisition.png";
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
		local specialistWeapon = false;

		switch (true) 
		{
			case item == null:
				return;
			case item.getID() == "weapon.legend_wooden_stake":
				return handleStake( _properties );
			case !item.isWeaponType(this.Const.Items.WeaponType.Crossbow): 
				return;
			case (item.getID() == "weapon.legend_hand_crossbow" || item.getID() == "weapon.goblin_crossbow"):
				specialistWeapon = true;
		}

		_properties.RangedSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInCrossbows)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}

	function handleStake( _properties )
	{

		local actor = this.getContainer().getActor();
		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, true);
		_properties.DamageRegularMin += actor.calculateSpecialistBonus(10, true);
		_properties.DamageRegularMax += actor.calculateSpecialistBonus(10, true);
	}

	function validTarget( _targetID)
	{
		if (_targetID == this.Const.EntityType.Hexe || _targetID == this.Const.EntityType.Alp)
		{
			return true;
		}
		return false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;
		if (item == null || !item.isWeaponType(this.Const.Items.WeaponType.Crossbow))
		{
			return;
		}

		if (item.getID() == "weapon.legend_hand_crossbow" || item.getID() == "weapon.goblin_crossbow")
		{
			specialistWeapon = true;
		}
		
		if (this.validTarget(_targetEntity.getType()))
		{
			_properties.RangedSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

			if (actor.getCurrentProperties().IsSpecializedInCrossbows)
			{
				_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
				_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
			}
		}
		else
		{
			return;
		}
	}
	
});
