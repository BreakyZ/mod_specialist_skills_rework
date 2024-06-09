::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_lute_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		switch (true) 
		{
			case item == null:
				return;
			case item.isWeaponType(this.Const.Items.WeaponType.Mace) && item.isItemType(this.Const.Items.ItemType.OneHanded):
				return handleMaces( _properties );
			case (!item.isWeaponType(this.Const.Items.WeaponType.Musical)):
				return;
		}
		_properties.MeleeSkill += actor.calculateSpecialistBonus(10, true);
		_properties.MeleeDefense += actor.calculateSpecialistBonus(10, true);
		_properties.DamageArmorMult += 0.01 * actor.calculateSpecialistBonus(50, true);

		if (actor.getCurrentProperties().IsSpecializedInStaves)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(10, true);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(10, true);
		}
	}	

	q.handleMaces <- function( _properties )
	{
		local actor = this.getContainer().getActor();
		_properties.MeleeSkill += actor.calculateSpecialistBonus(12);
		_properties.FatigueDealtPerHitMult += actor.calculateSpecialistBonus(2);

		if (actor.getCurrentProperties().IsSpecializedInMaces)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16);
		}
	}
});
