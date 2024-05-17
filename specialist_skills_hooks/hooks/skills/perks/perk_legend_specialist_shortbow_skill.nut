::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_shortbow_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		if (item != null && item.isWeaponType(this.Const.Items.WeaponType.Bow))
		{
			if (item.isItemType(this.Const.Items.ItemType.Shortbow))
			{
				specialistWeapon = true
			}
			_properties.RangedSkill += actor.calculateSpecialistMultiplier(0.08, specialistWeapon);
			_properties.DamageDirectAdd += actor.calculateSpecialistMultiplier(0.17, specialistWeapon) * 0.01;
		}
	}
});
