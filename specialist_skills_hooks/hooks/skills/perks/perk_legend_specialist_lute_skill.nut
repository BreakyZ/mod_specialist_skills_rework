::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_lute_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();

		if (item == null || !item.isWeaponType(this.Const.Items.WeaponType.Musical)) return;

		_properties.MeleeSkill += actor.calculateSpecialistBonus(10, true);
		_properties.MeleeDefense += actor.calculateSpecialistBonus(10, true);
		_properties.DamageArmorMult += 0.01 * actor.calculateSpecialistBonus(50, true);

		if (actor.getCurrentProperties().IsSpecializedInStaves || actor.getCurrentProperties().IsSpecializedInMaces)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(10, true);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(10, true);
		}
	}
});
