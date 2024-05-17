::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_ninetails_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		if (item != null && item.isItemType(this.Const.Items.ItemType.Cultist))
		{
			if (item.getID() == "weapon.legend_cat_o_nine_tails")
			{
				specialistWeapon = true
			}
			_properties.MeleeSkill += actor.calculateSpecialistMultiplier(0.08, specialistWeapon);
			_properties.DamageAgainstMult[this.Const.BodyPart.Head] += actor.calculateSpecialistMultiplier(0.001, specialistWeapon);
		}
	}
});