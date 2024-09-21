this.legend_slinger_spins_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.legend_slinger_spins";
		this.m.Name = "Prepare Bullet";
		this.m.Description = "This character is preparing a shot with a sling, increasing velocity and damage.";
		this.m.Icon = "ui/effects/slinger_spins.png";
		// this.m.IconMini = "slinger_spins_mini.png";
		// this.m.Overlay = "slinger_spins";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]20%[/color] Ranged Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "Switching your weapon will remove this effect"
			}
		];
		local sourcePerk = this.getContainer().getSkillByID("perk.legend_specialist_sling_skill");
		if (source_perk && sourcePerk.m.armorDamageApplied > 0)
			ret.push(
			{
					id = 12,
					type = "text",
					icon = "ui/icons/damage_dealt.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + sourcePerk.m.armorDamageApplied +"%[/color] Armor Penetration"
			});
		return ret;
	}

	function onUpdate( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (!(weapon.getID() == "weapon.legend_sling" && weapon.getID() == "weapon.named_sling"))
			this.removeSelf();
			return;
	}

	function onMovementCompleted( _tile )
	{
		this.removeSelf();
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		this.removeSelf();
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isGarbage() || !_skill.getID() == "actives.sling_stone")
			return;
		_properties.DamageRegularMin *= 1.2;
		_properties.DamageRegularMax *= 1.2;
		local sourcePerk = this.getContainer().getSkillByID("perk.legend_specialist_sling_skill");
		if (sourcePerk)
			_properties.DamageDirectAdd += sourcePerk.m.armorDamageApplied;
		this.removeSelf();
	}
});
