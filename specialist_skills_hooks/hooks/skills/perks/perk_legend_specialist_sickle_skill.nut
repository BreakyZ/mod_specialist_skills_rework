::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_sickle_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		if (item != null && item.isItemType(this.Const.Items.ItemType.OneHanded) && item.isWeaponType(this.Const.Items.WeaponType.Sword))
		{

			if (item.getID() == "weapon.sickle" || item.getID() == "weapon.goblin_notched_blade"  || item.getID() == "weapon.legend_named_sickle")
			{
				specialistWeapon = true
			}
			_properties.MeleeSkill += actor.calculateSpecialistMultiplier(0.08, specialistWeapon);
			_properties.DamageArmorMult += actor.calculateSpecialistMultiplier(0.17, specialistWeapon) * 0.01;
		}
	}
});
