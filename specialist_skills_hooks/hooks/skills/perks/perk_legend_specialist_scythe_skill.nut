::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_scythe_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		if (item == null || !(item.getID() == "weapon.legend_grisly_scythe" || item.getID() == "weapon.legend_scythe" || item.getID() == "weapon.warscythe" || item.getID() == "weapon.named_warscythe"))
		{
			return;
		}

		_properties.MeleeSkill += 15;

		if (actor.getCurrentProperties().IsSpecializedInPolearms || actor.getCurrentProperties().IsSpecializedInCleavers)
		{
			_properties.DamageRegularMin += 10;
			_properties.DamageRegularMax += 15;
		}
	}
});
