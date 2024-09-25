::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/legend_sling_heavy_stone_skill", function ( q )
{
	q.m.AdditionalAccuracy = 0;
	q.m.AdditionalHitChance = -6;

	q.getTooltip = @(__original) function()
	{
		local ret = this.getRangedTooltip(this.getDefaultTooltip());

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInStaffStun == true)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.NegativeValue + "]100%[/color] chance to stun and daze target on a hit to the head if not immune and always staggers the target"
			});	
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.NegativeValue + "]100%[/color] chance to daze a target on a hit to the head and always staggers the target"
			});	
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	q.onAfterUpdate = @( __original) function ( _properties )
	{
		this.m.FatigueCostMult = 1.0;
		if (_properties.IsSpecializedInSlings)
		{
			this.m.MaxRange = this.m.Item.getRangeMax() + 1;	
			this.m.AdditionalAccuracy += 5;
			this.m.AdditionalHitChance += 2;
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost += 1;
			this.m.FatigueCost += 4;
		}
		if (this.getContainer().hasSkill("perk.legend_barrage"))
		{
			this.m.ActionPointCost += 1;
			this.m.FatigueCost += 4;
		}
	}

	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;

			if (this.getContainer().hasSkill("perk.legend_barrage"))
			{
				_properties.DamageRegularMin += 15;
				_properties.DamageRegularMax += 30;
				_properties.DamageArmorMult *= 0.50;
			}
		}
	}

	q.onTargetHit = @(__original) function(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor)
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));

		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying() && !_targetEntity.getCurrentProperties().IsImmuneToDaze)
		{
			local targetTile = _targetEntity.getTile();
			local user = this.getContainer().getActor();

			if (_bodyPart == this.Const.BodyPart.Head)
			{
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
				
				if (user.getCurrentProperties().IsSpecializedInStaffStun)
					if (!_targetEntity.getCurrentProperties().IsImmuneToStun)
						_targetEntity.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));
						if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
							this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " stunned and dazed");
							return;
				
				if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " dazed");
			}
		}
	}
});