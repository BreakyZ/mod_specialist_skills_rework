this.perk_legend_barrage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_barrage";
		this.m.Name = this.Const.Strings.PerkName.LegendBarrage;
		this.m.Description = this.Const.Strings.PerkDescription.LegendBarrage;
		this.m.Icon = "ui/perks/catapult_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate(_properties)
	{
		_properties.HitChanceAdditionalWithEachTile += 2;
		if (item.getID() == "weapon.legend_slingstaff" || item.getID() == "weapon.named_northern_sling" || item.getID() == "weapon.nomad_sling")
		{
			_properties.DamageRegularMin += 15;
			_properties.DamageRegularMax += 30;
			_properties.DamageArmorMult += 0.50;
		}
	}
});
