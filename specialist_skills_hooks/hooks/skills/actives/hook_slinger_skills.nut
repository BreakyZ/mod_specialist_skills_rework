::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/legend_sling_heavy_stone_skill", function ( q )
{
	q.onAfterUpdate = @( __original) function ( _properties )
	{
		this.m.MaxRange = this.m.Item.getRangeMax() + (_properties.IsSpecializedInSlings ? 1 : 0);
		this.m.AdditionalAccuracy -= _properties.IsSpecializedInSlings ? 0 : -5;
		this.m.AdditionalHitChance = _properties.IsSpecializedInSlings ? -2 : -4;
		this.m.FatigueCostMult = _properties.IsSpecializedInSlings ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		if (this.getContainer().hasSkill("perk.legend_mastery_slings"))
		{
			this.m.ActionPointCost += 1;
			this.m.FatigueCost += 4;
		}
		if (this.getContainer().hasSkill("perk.barrage"))
		{
			this.m.ActionPointCost += 1;
			this.m.FatigueCost = 4;
		}
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
});