::Const.GetWeaponClassTree <- function ( _item ) {

	switch(true) {
	//Shovel
		case _item.getID() == "weapon.legend_shovel" || _item.getID() == "weapon.legend_named_shovel":
			return this.Const.Perks.ShovelClassTree;

	//Sickle
		case _item.getID() == "weapon.sickle" || _item.getID() == "weapon.goblin_notched_blade" || _item.getID() == "weapon.legend_named_sickle":
			return this.Const.Perks.SickleClassTree;

	//Wood Axe
		case _item.getID() == "weapon.woodcutters_axe" || _item.getID() == "weapon.legend_saw":
			return this.Const.Perks.WoodaxeClassTree;

	//Blacksmith
		case _item.getID() == "weapon.legend_hammer" || _item.getID() == "weapon.legend_named_blacksmith_hammer":
			return this.Const.Perks.HammerClassTree;

	//Pickaxe
		case _item.getID() == "weapon.pickaxe" || _item.getID() == "weapon.heavy_mining_pick":
			return this.Const.Perks.PickaxeClassTree;

	//Butcher
		case _item.getID() == "weapon.butchers_cleaver" || _item.getID() == "weapon.legend_named_butchers_cleaver":
			return this.Const.Perks.ButcherClassTree;

	//Ninetails
		case _item.getID() == "weapon.legend_cat_o_nine_tails":
			return this.Const.Perks.NinetailsClassTree;

	//Knife
		case _item.getID() == "weapon.knife" || _item.getID() == "weapon.legend_shiv":
			return this.Const.Perks.KnifeClassTree;

	//Inventor
		case _item.isWeaponType(this.Const.Items.WeaponType.Firearm):
			return this.Const.Perks.SpecialistInventorTree;

	//Bodyguard
		case _item.getID() == "weapon.legend_longsword":
			return this.Const.Perks.SpecialistBodyguardTree;

	//Slings
		case _item.getID() == "weapon.legend_sling":
			return this.Const.Perks.SpecialistSlingTree;

	//Staves
		case _item.getID() == "weapon.legend_staff":
			return this.Const.Perks.SpecialistStaffTree;

	//Inquisition
		case _item.getID() == "weapon.legend_wooden_stake":
			return this.Const.Perks.SpecialistInquisitionTree;

	//Club
		case _item.getID() == "weapon.wooden_stick":
			return this.Const.Perks.SpecialistClubTree;

	//Pitchfork
		case _item.isItemType(this.Const.Items.ItemType.Pitchfork):
			return this.Const.Perks.PitchforkClassTree;

	//Shortbow
		case _item.isItemType(this.Const.Items.ItemType.Shortbow):
			return this.Const.Perks.ShortbowClassTree;

	//Militia
		case _item.getID() == "weapon.militia_spear" || _item.getID() == "weapon.legend_wooden_spear" || _item.getID() == "weapon.ancient_spear":
			return this.Const.Perks.MilitiaClassTree;
	}

	return null;

}