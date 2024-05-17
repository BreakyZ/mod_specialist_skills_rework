::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_lute_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();

		if (item != null && (item.isWeaponType(this.Const.Items.WeaponType.Musical) || (item.isWeaponType(this.Const.Items.WeaponType.Mace) && item.isItemType(this.Const.Items.ItemType.OneHanded))))
		{	
			if (item.isWeaponType(this.Const.Items.WeaponType.Musical))
			{
				_properties.MeleeSkill += actor.calculateSpecialistMultiplier(0.07, true);
				_properties.MeleeDefense += actor.calculateSpecialistMultiplier(0.07, true);
				_properties.DamageArmorMult += actor.calculateSpecialistMultiplier(0.34, true) * 0.01;
			}
			else
			{
				_properties.MeleeSkill += actor.calculateSpecialistMultiplier(0.08);
				_properties.FatigueDealtPerHitMult += actor.calculateSpecialistMultiplier(0.014);		
			}
		}
	}
});
