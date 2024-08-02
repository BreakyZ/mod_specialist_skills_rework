local cleaver_skills = [
	"legend_voulge_cleave",
	"whip_skill",
	"legend_flaggelate_skill",
	"cleave"
]
if (Is_SSU_Exist)
{
	cleaver_skills.extend([
		"crcleave",
		"serrated_axe",
		"twincleavers_1",
		"ssu_bone_cleaver_swing"])
}
foreach (cleaver_skill in cleaver_skills)
{
	::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/" + cleaver_skill, function( q )
	{
		q.onUse = @(__original) function ( _user, _targetTile )
		{
			local target = _targetTile.getEntity();
			local hp = target.getHitpoints();
			local success = this.attackEntity(_user, _targetTile.getEntity());
			local actor = this.getContainer().getActor();

			if (!_user.isAlive() || _user.isDying())
			{
				return;
			}

			if (success && !_targetTile.IsEmpty)
			{
				if (!target.isAlive() || target.isDying())
				{
					if (this.isKindOf(target, "lindwurm_tail") || !target.getCurrentProperties().IsImmuneToBleeding)
					{
						this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
					}
					else
					{
						this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
					}
				}
				else if (!target.getCurrentProperties().IsImmuneToBleeding && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding)
				{
					local effect = this.new("scripts/skills/effects/bleeding_effect");
						if (_user.getFaction() == this.Const.Faction.Player )
						{
							effect.setActor(actor);
						}
					local damage = actor.getCurrentProperties().IsSpecializedInCleavers ? 10 : 5;
					if (actor.getFlags().has("cleaverSpecialist")) damage += 2;
					effect.setDamage(damage);
					target.getSkills().add(effect);
					effect = this.new("scripts/skills/effects/bleeding_effect");
						if (_user.getFaction() == this.Const.Faction.Player )
						{
							effect.setActor(actor);
						}
					effect.setDamage(damage);
					target.getSkills().add(effect);
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
}
if (Is_SSU_Exist)
{
	::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/ssu_bone_cleaver_flurry", function( q ) 
	{
		q.onUse = @(__original) function ( _user, _targetTile )
		{
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
			local target = _targetTile.getEntity();
			local hp = target.getHitpoints();
			local success = this.attackEntity(_user, _targetTile.getEntity());
			local damage = this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5
			if (actor.getFlags().has("cleaverSpecialist")) damage += 2;

			if (this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _user.getID() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
			{
				this.m.IsDoingAttackMove = false;
				this.getContainer().setBusy(true);

				for (local i = 0; i < 4; i++) // 4 attacks
				{
					this.Time.scheduleEvent(this.TimeUnit.Virtual, 200 + (i * 50), function ( _skill )
					{
						if (target.isAlive())
							_skill.attackEntity(_user, target);

						if (i == 3) // On the 4th attack, unlock char
						{
							_skill.m.IsDoingAttackMove = true;
							_skill.getContainer().setBusy(false);
						}
					}.bindenv(this), this);
				}
			}
			else
			{
				for (local i = 0; i < 4; i++)
					if (target.isAlive())
						ret = this.attackEntity(_user, target) || ret;
			}

			if (!target.isAlive() || target.isDying() || !target.getCurrentProperties().IsImmuneToBleeding && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding)
			{
				local effect = this.new("scripts/skills/effects/bleeding_effect");
				effect.setDamage(damage);
				effect.m.bleed_type = 100;
				target.getSkills().add(effect);
			}

			return ret; // 5th attack
		}
	});
	::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/twincleavers_2", function( q ) 
	{
		q.onUse = @(__original) function ( _user, _targetTile )
			{
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
			local target = _targetTile.getEntity();
			local ret = this.attackEntity(_user, target);
			local hp = target.getHitpoints();
			local actor = this.getContainer().getActor();
			local damage = actor.getCurrentProperties().IsSpecializedInCleavers ? 10 : 5
			if (actor.getFlags().has("cleaverSpecialist")) damage += 2;

			if (this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _user.getID() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
			{
				this.m.IsDoingAttackMove = false;
				this.getContainer().setBusy(true);

				for (local i = 0; i < 4; i++) // 4 attacks
				{
					this.Time.scheduleEvent(this.TimeUnit.Virtual, 200 + (i * 50), function ( _skill )
					{
						if (target.isAlive())
						{
							_skill.attackEntity(_user, target);
							if (!target.isAlive() || target.isDying() || !target.getCurrentProperties().IsImmuneToBleeding && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding)
							{
								local effect = this.new("scripts/skills/effects/bleeding_effect");
								effect.setDamage(damage);
								target.getSkills().add(effect);
							}
						}

						if (i == 3) // On the 4th attack, unlock char
						{
							_skill.m.IsDoingAttackMove = true;
							_skill.getContainer().setBusy(false);
						}
					}.bindenv(this), this);
				}
			}
			else
			{
				for (local i = 0; i < 4; i++)
				{
					if (target.isAlive())
					{
						ret = this.attackEntity(_user, target) || ret;
						if (!target.isAlive() || target.isDying() || !target.getCurrentProperties().IsImmuneToBleeding && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding)
						{
							local effect = this.new("scripts/skills/effects/bleeding_effect");
							effect.setDamage(damage);
							target.getSkills().add(effect);
						}
					}
				}
			}

			if (!target.isAlive() || target.isDying() || !target.getCurrentProperties().IsImmuneToBleeding && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding)
			{
				local effect = this.new("scripts/skills/effects/bleeding_effect");
				effect.setDamage(damage);
				target.getSkills().add(effect);
			}

			return ret; // 5th attack
		}
	});
}