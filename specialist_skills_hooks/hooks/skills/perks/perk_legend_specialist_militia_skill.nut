::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_militia_skill", function ( q )
{
	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local off = actor.getOffhandItem();
		local specialistWeapon = false
		local isGlaive = false

		switch (true) 
		{
			case item == null:
				return;
			case !item.isWeaponType(this.Const.Items.WeaponType.Spear):
				return;
			case item.getID() == "weapon.militia_spear" || item.getID() == "weapon.legend_wooden_spear" || item.getID() == "weapon.ancient_spear":
				specialistWeapon = true;
			case this.canDoubleGrip() && this.isGlaive():
				isGlaive = true 
		}

		if (item.isWeaponType(this.Const.Items.WeaponType.Throwing))
		{
			_properties.RangedSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
		}
		else
		{
			_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);
			_properties.MeleeDefense += actor.calculateSpecialistBonus(6, specialistWeapon);
			if (isGlaive)
			{
				_properties.MeleeDefense += actor.calculateSpecialistBonus(6, specialistWeapon);
				_properties.RangedDefense += actor.calculateSpecialistBonus(6, specialistWeapon);
			}
		}
		
		if (actor.getCurrentProperties().IsSpecializedInSpears)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}

	q.canDoubleGrip <- function()
	{
		local missinghand = this.m.Container.getSkillByID("injury.missing_hand");
		local newhand = this.m.Container.getSkillByID("trait.legend_prosthetic_hand");
		local main = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return (missinghand == null || newhand != null) && main != null && off == null && main.isDoubleGrippable();
	}

	q.isGlaive <- function()
	{
		local mainId = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getID();

		foreach (glaiveId in [
			"weapon.legend_glaive",
			"weapon.legend_battle_glaive",
			"weapon.legend_named_glaive",
			"weapon.legend_militia_glaive"] )
		{
			if (mainId == glaiveId) return true;
		}
		return false;
	}
});
