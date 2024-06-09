::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_ninetails_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		switch (true) 
		{
			case item == null:
				return;
			case item.getID() == "weapon.orc_flail_2h" || item.getID() == "weapon.named_orc_flail_2h":
				return handleNoneCultist();
			case !item.isItemType(this.Const.Items.ItemType.Cultist):
				return;
			case item.getID() == "weapon.legend_cat_o_nine_tails":
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.01 * actor.calculateSpecialistBonus(15, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInFlails)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}

	q.handleNoneCultist <- function( _properties )
	{
		local actor = this.getContainer().getActor();
		_properties.MeleeSkill += actor.calculateSpecialistBonus(8, false);
		_properties.DamageAgainstMult[this.Const.BodyPart.Head] +=0.01 * actor.calculateSpecialistBonus(10, false);

		if (actor.getCurrentProperties().IsSpecializedInFlails || actor.getCurrentProperties().IsSpecializedInCleavers)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(4, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(12, specialistWeapon);
		}


	}
});