::ModSpecialistSkillsRework.HooksMod.hook("scripts/items/tools/daze_bomb_item", function ( q ) {
	
	if (!::Is_SSU_Exist)
	{
		q.create = @(__original) function()
		{
			__original();
			this.m.Description = "A throwable pot filled with mysterious powders that react violently on impact to create a bright flash and loud bang. Will daze anyone close by. If the company has Alchemy Tools, this item is refilled after each battle, consuming 30 ammunition per use.";
			this.m.Value = 1000;
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
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will give up to [color=" + this.Const.UI.Color.DamageValue + "]7[/color] targets the Dazed status effect for 2 turns"
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
				this.m.Name = "Flash Pot";
				this.m.IconLarge = "tools/daze_bomb_01.png";
				this.m.Icon = "tools/daze_bomb_01_70x70.png";
				this.m.ShowArmamentIcon = true;
			}
			else
			{
				this.m.Name = "Flash Pot (Used)";
				this.m.IconLarge = "tools/daze_bomb_01.png";
				this.m.Icon = "tools/daze_bomb_01_70x70.png";
				this.m.ShowArmamentIcon = false;
			}

			this.updateAppearance();
		}
	}
});
