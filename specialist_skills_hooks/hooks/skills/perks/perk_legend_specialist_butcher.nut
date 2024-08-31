::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/perks/perk_legend_specialist_butcher_skill", function ( q )
{
	q.m.SoundsA <- [
		"sounds/combat/cleave_hit_hitpoints_01.wav",
		"sounds/combat/cleave_hit_hitpoints_02.wav",
		"sounds/combat/cleave_hit_hitpoints_03.wav"
	];
	q.m.SoundsB <- [
		"sounds/combat/chop_hit_01.wav",
		"sounds/combat/chop_hit_02.wav",
		"sounds/combat/chop_hit_03.wav"
	];

	q.create = @(__original) function()
	{
		__original();
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	q.getDescription <- function()
	{
		return "Diligent practice with the hammer each day has proven to be equally good at crafting armor and finding it\'s weak points.";
	}

	q.getTooltip <- function()
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;
		switch (true) 
		{
			case item == null:
			case item.isWeaponType(this.Const.Items.WeaponType.Whip):
			case !item.isWeaponType(this.Const.Items.WeaponType.Cleaver):
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "This character is not using the specialist weapon or hasn\'t accumulated a bonus yet"
				});
				return tooltip;
			}
			case item.getID() == "weapon.butchers_cleaver" || item.getID() == "weapon.legend_named_butchers_cleaver":
				specialistWeapon = true;
		}

		if (actor.calculateSpecialistBonus(12, specialistWeapon) == 0)
		{
			tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]This character is not using the specialist weapon or hasn\'t accumulated a bonus yet[/color]"
				});
			return tooltip;
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(12, specialistWeapon) + "[/color] Melee Skill"
			});
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Applies [color=" + this.Const.UI.Color.PositiveValue + "]2[/color] Bleeding Damage to every attack" 
			});
			if (actor.getCurrentProperties().IsSpecializedInCleavers)
			{
				tooltip.push({
					id = 7,
					type = "text",
					icon = "ui/icons/damage_dealt.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + actor.calculateSpecialistBonus(6, specialistWeapon) + "-" + actor.calculateSpecialistBonus(16, specialistWeapon) + "[/color] Damage"
				});
			}

		}

		return tooltip;
	}

	q.onUpdate = @( __original ) function( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local specialistWeapon = false;

		switch (true)
		{
			case item == null:
				return;
			case item.isWeaponType(this.Const.Items.WeaponType.Whip):
				return;
			case !item.isWeaponType(this.Const.Items.WeaponType.Cleaver):
				return;
			case item.getID() == "weapon.butchers_cleaver" || item.getID() == "weapon.legend_named_butchers_cleaver":
				specialistWeapon = true;
		}

		_properties.MeleeSkill += actor.calculateSpecialistBonus(12, specialistWeapon);

		if (actor.getCurrentProperties().IsSpecializedInCleavers)
		{
			_properties.DamageRegularMin += actor.calculateSpecialistBonus(6, specialistWeapon);
			_properties.DamageRegularMax += actor.calculateSpecialistBonus(16, specialistWeapon);
		}
	}

	q.onAnySkillUsed <- function( _skill, _targetEntity, _properties )
	{	
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		if (item == null || item.isWeaponType(this.Const.Items.WeaponType.Whip) || !item.isWeaponType(this.Const.Items.WeaponType.Cleaver))
			return;

		this.spawnAttackEffect(_targetEntity.getTile(), this.Const.Tactical.AttackEffectChop);
		local hp = _targetEntity.getHitpoints();
		local success = this.attackEntity(_user, _targetEntity);

		if (!_user.isAlive() || _user.isDying())
		{
			return;
		}

		if (success)
		{
			if (!_targetEntity.isAlive() || _targetEntity.isDying())
			{
				if (this.isKindOf(_targetEntity, "lindwurm_tail") || !_targetEntity.getCurrentProperties().IsImmuneToBleeding)
				{
					this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
				else
				{
					this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
			}
			else if (!_targetEntity.getCurrentProperties().IsImmuneToBleeding && hp - _targetEntity.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding )
			{
				local effect = this.new("scripts/skills/effects/legend_grazed_effect");
				if (_user.getFaction() == this.Const.Faction.Player )
				{
					effect.setActor(this.getContainer().getActor());
				}
				_targetEntity.getSkills().add(effect);
				if (!user.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " filleted " + this.Const.UI.getColorizedEntityName(_targetEntity) + " leaving them grazed");
				}
				this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
			else
			{
				this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
		}

		return success;
	}
});
