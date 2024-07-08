::ModSpecialistSkillsRework.HooksMod.hook("scripts/entity/world/camp/buildings/gatherer_building", function ( q )
{
	q.getAllLevels = @(__original) function()
	{
		local map = {
			Brewer = 0,
			Woodsman = 0,
			Miner = 0,
			Apothecary = 0
		};
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			if (bro.getCampAssignment() != this.m.ID) continue;

			if (bro.getSkills().hasSkill("perk.legend_potion_brewer")) map.Brewer += bro.getLevel();

			if (bro.getSkills().hasSkill("perk.legend_specialist_woodaxe_skill")) map.Woodsman += bro.getLevel();

			if (bro.getSkills().hasSkill("perk.legend_specialist_pickaxe_skill")) map.Miner += bro.getLevel();

			switch (bro.getBackground().getID())
			{
				case "background.legend_vala":
				case "background.legend_vala_commander":
				case "background.legend_herbalist":
				case "background.legend_alchemist":
				case "background.legend_druid":
				case "background.legend_druid_commander":
					map.Apothecary += bro.getLevel()
			}

			if (bro.getSkills().hasSkill("perk.legend_gatherer")) map.Apothecary += bro.getLevel();
		}
		return map;
	}
});
