::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_pitchfork_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		if (item != null && (item.isWeaponType(this.Const.Items.ItemType.Pitchfork) || item.isWeaponType(this.Const.Items.WeaponType.Polearm)))
		{

			if (item.isItemType(this.Const.Items.ItemType.Pitchfork))
			{
				specialistWeapon = true
			}
			_properties.MeleeSkill += actor.calculateSpecialistMultiplier(0.08, specialistWeapon);
			_properties.DamageArmorMult += actor.calculateSpecialistMultiplier(0.17, specialistWeapon) * 0.01;
		}
	}
});
