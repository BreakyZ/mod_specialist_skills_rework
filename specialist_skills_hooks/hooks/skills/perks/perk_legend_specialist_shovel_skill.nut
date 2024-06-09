::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_shovel_skill", function ( q )
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
			case !item.isItemType(this.Const.Items.ItemType.TwoHanded):
				return;
			case !item.isWeaponType(this.Const.Items.WeaponType.Mace):
				return;
			case item.getID() == "weapon.legend_shovel" || item.getID() == "weapon.legend_named_shovel":
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInMaces)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}

	q.onAdded = @( __original ) function()
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();

		if (item != null && (item.getID() == "weapon.legend_shovel" || item.getID() == "weapon.legend_named_shovel") && !actor.getSkills().hasSkill("actives.knock_out"))
		{
			item.addSkill(this.new("scripts/skills/actives/knock_out"));
		}
	}

	function onRemoved()
	{
		this.getContainer().getActor().getSkills().removeByID("actives.knock_out");
	}
});
