::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_adaptive", function( q ) 
{	
	q.getWeaponPerkTree = @(__original) function( _item )
	{
		switch(true) {
			// check the special weapon types first then the generic weapon types

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
				case _item.getID() == "weapon.pickaxe":
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

			//Banner
				case _item.getID() == "weapon.player_banner":
					return this.Const.Perks.InspirationalTree;

			//Inventor
				case _item.isWeaponType(this.Const.Items.WeaponType.Firearm):
					return this.Const.Perks.SpecialistInventorTree;

			//Bodyguard
				case _item.getID() == "weapon.legend_longsword":
					return this.Const.Perks.SpecialistBodyguardTree;

			//Inquisition
				case _item.getID() == "weapon.legend_wooden_stake":
					return this.Const.Perks.SpecialistInquisitionTree;

			//Pitchfork
				case _item.isItemType(this.Const.Items.ItemType.Pitchfork):
					return this.Const.Perks.PitchforkClassTree;

			//Musical
				case _item.isWeaponType(this.Const.Items.WeaponType.Musical):
					return this.Const.Perks.BardClassTree;

			//Shortbow
				case _item.isItemType(this.Const.Items.ItemType.Shortbow):
					return this.Const.Perks.ShortbowClassTree;

			//Militia
				case _item.getID() == "weapon.militia_spear" || _item.getID() == "weapon.legend_wooden_spear" || _item.getID() == "weapon.ancient_spear":
					return this.Const.Perks.MilitiaClassTree;

			//Greatsword				
				case _item.isWeaponType(this.Const.Items.WeaponType.Sword) && _item.isItemType(this.Const.Items.ItemType.TwoHanded):
					return this.Const.Perks.GreatSwordTree;

			// WeaponTypes
				default:
					local ret = []; // Push all applicable WeaponTypes into array (supports Hybrid weapons)
					local weaponToPerkMap = {
						Axe = this.Const.Perks.AxeTree,
						Bow = this.Const.Perks.BowTree,
						Cleaver = this.Const.Perks.CleaverTree,
						Crossbow = this.Const.Perks.CrossbowTree,
						Dagger = this.Const.Perks.DaggerTree,
						Firearm = this.Const.Perks.CrossbowTree,
						Flail = this.Const.Perks.FlailTree,
						Hammer = this.Const.Perks.HammerTree,
						Mace = this.Const.Perks.MaceTree,
						Polearm = this.Const.Perks.PolearmTree,
						Sling = this.Const.Perks.SlingTree,
						Spear = this.Const.Perks.SpearTree,
						Sword = this.Const.Perks.SwordTree,
						Staff = this.Const.Perks.StaffTree,
						Throwing = this.Const.Perks.ThrowingTree
					}
					foreach (weapon, tree in weaponToPerkMap)
					{
						if (_item.isWeaponType(this.Const.Items.WeaponType[weapon])) ret.push(tree);
					}
					return ret;
		}

		return null;
	}
});