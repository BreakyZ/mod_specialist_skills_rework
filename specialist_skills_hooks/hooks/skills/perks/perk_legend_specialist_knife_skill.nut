::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_knife_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		if (item != null && item.isWeaponType(this.Const.Items.WeaponType.Dagger))
		{

			if (item.getID() == "weapon.knife" || item.getID() == "weapon.legend_shiv")
			{
				specialistWeapon = true
			}
			_properties.MeleeSkill += actor.calculateSpecialistMultiplier(0.08, specialistWeapon);
			_properties.DamageDirectMult += actor.calculateSpecialistMultiplier(0.27, specialistWeapon) * 0.01;
		}
	}
});
