::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/effects/legend_drums_of_life_effect", function( q )
{
	q.m.Effect <- 0;

	q.getEffect <- function()
	{
		return this.m.Effect;
	}

	q.setEffect <- function( _e )
	{
		this.m.Effect = _e;
	}

	q.onAdded = @(__original) function()
	{

		local actor = this.getContainer().getActor();
		if (actor.getHitpoints() < actor.getHitpointsMax())
		{
			actor.setHitpoints(this.Math.max(0, this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + this.m.Effect)) );
			this.spawnIcon(this.m.Overlay, actor.getTile());
		}
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/effects/legend_drums_of_war_effect", function( q )
{
	q.m.Effect <- 0;

	q.getEffect <- function()
	{
		return this.m.Effect;
	}

	q.setEffect <- function( _e )
	{
		this.m.Effect = _e;
	}

	q.onAdded = @(__original) function()
	{
		local actor = this.getContainer().getActor();

		actor.setFatigue(this.Math.max(0, actor.getFatigue() - this.m.Effect));
		this.spawnIcon(this.m.Overlay, actor.getTile());
	}
});
