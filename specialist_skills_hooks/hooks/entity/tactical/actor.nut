::ModSpecialistSkillsRework.HooksMod.hook("scripts/entity/tactical/actor", function ( q )
{
	q.calculateSpecialistBonus <- function( _stat, _specialistWeapon = false)
	{
		if (_specialistWeapon || !this.isPlayerControlled())
		{
			return _stat;
		}
		local dc;
		if (::ModSpecialistSkillsRework.Mod.ModSettings.getSetting("SSUStyle").getValue())
		{
			dc = this.getDaysWithCompany();
		
			dc = this.Math.floor(dc / 7);
			return this.Math.floor(0.01 * this.Math.min(5 * dc + 25, 100) * _stat);
		}
		else if (this.getLevel() - 5 > 0)
		{
			return this.Math.floor((this.Math.min(15, this.getLevel()) - 5) * 0.1 * _stat);
		}
		else
		{
			return 0;
		}
	}
});
