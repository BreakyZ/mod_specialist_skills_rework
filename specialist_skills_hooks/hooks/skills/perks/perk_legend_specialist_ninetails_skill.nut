::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_ninetails_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		if (item != null && (item.isItemType(this.Const.Items.ItemType.Cultist) || item.getID() == "weapon.orc_flail_2h" || item.getID() == "weapon.named_orc_flail_2h"))
		{
			if (item.getID() == "weapon.legend_cat_o_nine_tails")
			{
				specialistWeapon = true
			}
			_properties.MeleeSkill += actor.calculateSpecialistMultiplier(0.08, specialistWeapon);
			_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.01 * actor.calculateSpecialistMultiplier(0.1, specialistWeapon);
		}
		if (item != null && item.getID() == "weapon.three_headed_flail")
		{
			_properties.MeleeSkill += actor.calculateSpecialistMultiplier(0.04, false);
			_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.01 * actor.calculateSpecialistMultiplier(0.05, false);
		}
	}
});