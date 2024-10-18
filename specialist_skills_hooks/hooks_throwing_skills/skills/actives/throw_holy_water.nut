::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/throw_holy_water", function( q ) {

	q.m.Item = null;
	q.setItem <- function( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	q.getTooltip = @( __original ) function()
	{
		local ret = __original();
		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] use left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Has been used[/color]"
			});
		}

		return ret;
	}

	q.isHidden <- function()
	{
		return this.getContainer().getActor().getCurrentProperties().IsSpecializedInNets;
	}

	q.isUsable <- function()
	{
		return !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0 && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	q.getAmmo <- function()
	{
		if (this.m.Item == null && this.m.Item.isNull())
			return 0;

		return this.m.Item.getAmmo();
	}

	q.consumeAmmo <- function()
	{
		if (this.m.Item != null && !this.m.Item.isNull())
			this.m.Item.consumeAmmo();
	}

	q.onUse = @( __original ) function( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();

		if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
		{
			local flip = !this.m.IsProjectileRotated && targetEntity.getPos().X > _user.getPos().X;

			if (_user.getTile().getDistanceTo(targetEntity.getTile()) >= this.Const.Combat.SpawnProjectileMinDist)
			{
				this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), targetEntity.getTile(), 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			}
		}

		this.consumeAmmo();

		this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onApplyEffect.bindenv(this), {
			Skill = this,
			TargetTile = _targetTile
		});
	}

	q.onAfterUpdate = @( __original ) function( _properties )
	{
		this.m.FatigueCostMult = (_properties.IsSpecializedInThrowing || _properties.IsSpecializedInNets) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.MaxRange = _properties.IsSpecializedInNets ? 4 : 3;
	}

});