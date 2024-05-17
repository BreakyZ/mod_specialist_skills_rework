::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_shovel_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false

		if (item != null && item.isWeaponType(this.Const.Items.WeaponType.Mace) && item.isItemType(this.Const.Items.ItemType.TwoHanded))
		{

			if (item.getID() == "weapon.legend_shovel" || item.getID() == "weapon.legend_named_shovel")
			{
				specialistWeapon = true
			}
			_properties.MeleeSkill += actor.calculateSpecialistMultiplier(0.08, specialistWeapon);
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
