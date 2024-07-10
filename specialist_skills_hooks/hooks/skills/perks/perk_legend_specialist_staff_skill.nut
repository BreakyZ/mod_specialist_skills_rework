::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_staff_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;

		switch (true) 
		{
			case item == null:
				return;
			case item.isWeaponType(this.Const.Items.WeaponType.Staff) && item.isWeaponType(this.Const.Items.WeaponType.Sling):
				return handleHybrid( _properties );
			case item.isWeaponType(this.Const.Items.WeaponType.Staff) && item.isWeaponType(this.Const.Items.WeaponType.Sword):
				return handleHybrid( _properties );
			case item.isWeaponType(this.Const.Items.WeaponType.Musical):
				return handleHybrid( _properties );
			case (!item.isWeaponType(this.Const.Items.WeaponType.Staff)):
				return;
			case (!item.isWeaponType(this.Const.Items.WeaponType.MagicStaff)):
				specialistWeapon = true;
		}

		_properties.MeleeDefense += actor.calculateSpecialistBonus(16, specialistWeapon);
		_properties.RangedDefense += actor.calculateSpecialistBonus(16, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInStaves && !item.isWeaponType(this.Const.Items.WeaponType.Sling))
		{
			_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		}
	}

	q.handleHybrid <- function( _properties )
	{
		local actor = this.getContainer().getActor();
		_properties.MeleeDefense += actor.calculateSpecialistBonus(8);
		_properties.RangedDefense += actor.calculateSpecialistBonus(8);
	}
});
