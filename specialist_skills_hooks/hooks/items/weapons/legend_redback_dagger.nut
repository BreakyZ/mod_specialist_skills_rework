::ModSpecialistSkillsRework.HooksMod.hook("scripts/items/weapons/legend_redback_dagger", function( q )
{	
	q.m.hasDeathblow <- false;
	q.m.SoundOnUse <- [
		"sounds/combat/puncture_01.wav",
		"sounds/combat/puncture_02.wav",
		"sounds/combat/puncture_03.wav"
	];
	q.m.SoundOnHit <- [
		"sounds/combat/puncture_hit_01.wav",
		"sounds/combat/puncture_hit_02.wav",
		"sounds/combat/puncture_hit_03.wav"
	];
	q.create = @(__original) function()
	{
		__original();
		this.m.SoundOnUse = [
			"sounds/combat/puncture_01.wav",
			"sounds/combat/puncture_02.wav",
			"sounds/combat/puncture_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/puncture_hit_01.wav",
			"sounds/combat/puncture_hit_02.wav",
			"sounds/combat/puncture_hit_03.wav"
		];
	}

	q.getTooltip = @(__original) function ()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Applies redback poison to the target on any successful attack, dealing 55 damage over 10 turns."
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Puncture damage is doubled vs targets in a web"
		});
		return result;
	}


	q.onEquip = @(__original) function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/stab"));
		this.addSkill(this.new("scripts/skills/actives/puncture"))
		local skill = this.new("scripts/skills/actives/deathblow_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}

	q.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (_skill != null && _skill.getID() == "actives.puncture" && _targetEntity != null && _targetEntity.getSkills().hasSkill("effects.web"))
		{
			_properties.DamageDirectMult *= 2.0;
		}
	}

	q.spawnIcon <- function ( _brush, _tile )
	{
		if (!_tile.IsVisibleForPlayer)
		{
			return;
		}

		this.Tactical.spawnIconEffect(_brush, _tile, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
	}

	q.onDamageDealt <- function( _target, _skill, _hitInfo )
	{
		if (_target.getCurrentProperties().IsImmuneToPoison || _hitInfo.DamageInflictedHitpoints <= this.Const.Combat.PoisonEffectMinDamage || _target.getHitpoints() <= 0)
		{
			return;
		}

		if (!_target.isAlive())
		{
			return;
		}

		if (_target.getFlags().has("undead"))
		{
			return;
		}

		if (!_target.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _target.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_target) + " is poisoned");
		}

		this.spawnIcon("status_effect_54", _target.getTile());
		local poison = _target.getSkills().getSkillByID("effects.legend_redback_spider_poison");
		local effect = this.new("scripts/skills/effects/legend_redback_spider_poison_effect");
		// local actor = this.getContainer().getActor();
		// if (actor.getFaction() == this.Const.Faction.Player )
		// {
		// 	effect.setActor(actor);
		// 	poison.setActor(actor);
		// }

		if (poison == null)
		{
			_target.getSkills().add(effect);
		}
		else
		{
			poison.resetTime();
		}
	}
});
