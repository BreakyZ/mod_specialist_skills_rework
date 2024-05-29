::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_scythe_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false
		local isScythe = false
		if (item == null)
		{
			return
		}
		if (item.getID() == "weapon.legend_grisly_scythe" || item.getID() == "weapon.legend_scythe" || item.getID() == "weapon.warscythe" || item.getID() == "weapon.named_warscythe")
		{
			isScythe = true
			specialistWeapon = true
		}

		if (item.isItemType(this.Const.Items.ItemType.TwoHanded) && (isScythe || item.isWeaponType(this.Const.Items.WeaponType.Sword)))
		{
			_properties.MeleeSkill += actor.calculateSpecialistMultiplier(0.08, specialistWeapon);
			_properties.DamageArmorMult += actor.calculateSpecialistMultiplier(0.17, specialistWeapon) * 0.01;
		}
	}
});
