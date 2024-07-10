this.bag_of_bullets <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.m.ID = "ammo.bullets";
		this.m.Name = "Bag of Bullets";
		this.m.Description = "A bag of weighted and smooth rocks, ensuring a higher velocity and better aim when used with a sling.";
		this.m.Icon = "ammo/bag_of_pebbles.png";
		this.m.IconEmpty = "ammo/bag_of_pebbles_empty.png";
		this.m.SlotType = this.Const.ItemSlot.Ammo;
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
		this.m.AmmoType = this.Const.Items.AmmoType.Bullets;
		// this.m.ShowOnCharacter = true;
		// this.m.ShowQuiver = true;
		this.m.Value = 35;
		this.m.Ammo = 10;
		this.m.AmmoMax = 10;
		this.m.IsDroppedAsLoot = false;
	}

	function getTooltip()
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

		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.m.Ammo != 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Contains [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color] bullets"
			});
		}
		else
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Is empty and useless[/color]"
			});
		}

		return result;
	}
	function onUpdateProperties( _properties )
	{
		if (this.m.ammo == 0) return;
		this.ammo.onUpdateProperties(_properties);
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item == null) return;
		if (!item.isWeaponType(this.Const.Items.WeaponType.Sling)) return;

		_properties.DamageDirectMult *= 0.9;
		_properties.RangedDamageMult *= 1.1;
		
	}
});

