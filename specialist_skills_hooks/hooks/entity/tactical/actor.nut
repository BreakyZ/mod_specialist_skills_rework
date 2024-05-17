::ModSpecialistSkillsRework.HooksMod.hook("scripts/entity/tactical/actor", function ( q )
{
	q.getHighestStat <- function()
	{	
		local stats = [this.getFatigueMax(), this.getInitiative(), this.getHitpointsMax()]
		local highest_stat = 0
		for( local i = 0; i < stats.len(); i = ++i )
		{
			if (stats[i] > highest_stat)
			{
				highest_stat = stats[i]
			}
		}
		if (highest_stat >= 150)
		{
			return 150;
		}
		else
		{
			return highest_stat;
		}
	}

	q.calculateSpecialistMultiplier <- function( _multiplier, _specialistWeapon = false )
	{
		local buffValue = 0
		local bonus = this.getHighestStat()
		if (_specialistWeapon && bonus < 150)
		{
			bonus = 150
		}
		else if (_specialistWeapon)
		{
			bonus += 20
		}

		if (bonus > 100)
		{
			buffValue += (bonus - 100) * _multiplier * 2.0
			buffValue += 100 * _multiplier / 2.0
		}
		else
		{
			buffValue += bonus * _multiplier / 2.0
		}
		return this.Math.floor(buffValue)
	}
});