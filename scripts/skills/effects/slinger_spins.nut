this.slinger_spins_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.slinger_spins";
		this.m.Name = "Prepare Bullet";
		this.m.Icon = "ui/effects/sling_02.png";
		this.m.IconMini = "slinger_spins_mini.png";
		this.m.Overlay = "sling_02";
		this.m.Description = "This character is preparing a shot with a sling, increasing velocity and accuracy.";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
	}

	function getTooltip()
	{
		local bonus = this.getCorpses();
		return [
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
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] Ranged Skill"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/tooltips/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]20%[/color] Ranged Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "Switching your weapon will remove this effect"
			}
		];
	}

	function onUpdate( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (!item.isWeaponType(this.Const.Items.WeaponType.Sling))
			this.removeSelf();
			return;
		_properties.DamageRegularMin *= 1.2;
		_properties.DamageRegularMax *= 1.2;
		_properties.RangedSkill = this.Math.floor( _properties.RangedSkill * 1.10 );

	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		this.removeSelf();
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isGarbage() || (!_skill.isAttack() && !_skill.isRanged()))
			return;
		this.removeSelf();
	}
});
