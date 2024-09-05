::ModSpecialistSkillsRework.HooksMod.hook("scripts/items/tools/holy_water_item", function ( q )
{
	if (!::Is_SSU_Exist)
	{
		q.create = @(__original) function()
		{
			__original();
			this.m.Description = "A flask filled with water blessed by a man of the gods. Can be thrown at short ranges. If the company has Alchemy Tools, this item is refilled after each battle, consuming 30 ammunition per use.";
			this.m.Value = 1300;
			this.m.ItemType = this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Tool;
			this.m.Ammo = 1;
			this.m.AmmoMax = 1;
			this.m.AmmoCost = 30;
			this.m.RangeMax = 3;
			this.m.StaminaModifier = 0;
			this.m.IsDroppedAsLoot = true;
		}

		q.getTooltip = @(__original) function()
		{
			local result = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				}
			];

			if (this.getIconLarge() != null)
			{
				result.push({
					id = 3,
					type = "image",
					image = this.getIconLarge(),
					isLarge = true
				});
			}
			else
			{
				result.push({
					id = 3,
					type = "image",
					image = this.getIcon()
				});
			}

			result.extend([
			{
				id = 66,
				type = "text",
				text = this.getValueString()
			},
			{
				id = 64,
				type = "text",
				text = "Worn in Offhand"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RangeMax + "[/color] tiles"
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Damage of [color=" + this.Const.UI.Color.DamageValue + "]20[/color] for [color=" + this.Const.UI.Color.DamageValue + "]3[/color] turns to any undead target hit"
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.DamageValue + "]33%[/color] chance to hit bystanders at the same or lower height level as well."
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=" + this.Const.UI.Color.DamageValue + "]100%[/color] of damage ignores armor"
			}]);
			if (!this.World.Retinue.hasFollower("follower.alchemist"))
			{
				result.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "Cannot be refilled after battle, because this company has no Alchemy Tools"
				});
			}
			return result;
		}

		q.isAmountShown <- function ()
		{
			return true;
		}

		q.getAmountString <- function ()
		{
			return this.m.Ammo + "/" + this.m.AmmoMax;
		}

		q.getAmmo <- function()
		{
			return this.m.Ammo;
		}

		q.setAmmo <- function ( _a )
		{
			this.weapon.setAmmo( _a );

			if (this.m.Ammo > 0)
			{
				this.m.Name = "Holy Water";
				this.m.IconLarge = "tools/holy_water_01.png";
				this.m.Icon = "tools/holy_water_01_70x70.png";
				this.m.ShowArmamentIcon = true;
			}
			else
			{
				this.m.Name = "Holy Water (Used)";
				this.m.IconLarge = "tools/holy_water_01.png";
				this.m.Icon = "tools/holy_water_01_70x70.png";
				this.m.ShowArmamentIcon = false;
			}

			this.updateAppearance();
		}
	}
});
