::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/legend_sling_heavy_stone_skill", function ( q )
{
	q.m.AdditionalAccuracy = 0;
	q.m.AdditionalHitChance = -6;

	// q.create = @( __original ) function ()
	// {
	// 	__original();
	// 		this.m.IsShieldRelevant = true;
	// }

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
		if (this.getContainer().hasSkill("perk.barrage"))
		{
			this.m.ActionPointCost += 1;
			this.m.FatigueCost = 4;
		}
		// doesn't make sense for this skill
		// if (this.getContainer().hasSkill("perk.legend_slinger_spins"))
		// {
		// 	this.m.IsShieldRelevant = false;
		// }
	}

	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			// replaces the damage portion as it'll be handled in the perk
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
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
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " stunned");
			}
		}
	}
});