this.legend_martial_march_effect <- this.inherit("scripts/skills/skill", {
	m = {
		songStacks = 0,
		turnsWithoutSong = 0,
	},
	function create()
	{
		this.m.ID = "effects.legend_military_march";
		this.m.Name = "Military March";
		this.m.Icon = "ui/effects/drums_of_war.png";
		this.m.IconMini = "drums_of_war_mini.png";
		this.m.Overlay = "drums_of_war";
		this.m.Description = "This character is being influenced by a martial march and is receiving stacking bonuses.";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
	}

	function getTooltip()
	{
		local bonus = this.getCorpses();
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.songStacks + "[/color] Initiative"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.songStacks + "[/color] Resolve"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.songStacks + "[/color] Melee and Ranged skill"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.songStacks + "[/color] Defense"
			}
		];
	}

	function onUpdate( _properties )
	{	
		local actorSkills = this.getContainer().getActor().getSkills();
		if (actorSkills.hasSkill("effects.legend_drums_of_life"))
		{
			this.m.songStacks += 1;
			this.m.turnsWithoutSong += 0;
			actorSkills.removeByID("effects.legend_drums_of_life");
		}
		else if (actorSkills.hasSkill("effects.legend_drums_of_war"))
		{
			this.m.songStacks += 1;
			this.m.turnsWithoutSong = 0;
			actorSkills.removeByID("effects.legend_drums_of_war");
		}

		_properties.Initiative += this.m.songStacks;
		_properties.Bravery += this.m.songStacks;
		_properties.MeleeSkill += this.m.songStacks;
		_properties.RangedSkill += this.m.songStacks;
		_properties.RangedSkill += this.m.songStacks;
		_properties.RangedSkill += this.m.songStacks;
	}

	function onTurnEnd()
	{
		this.m.turnsWithoutSong += 1;
		if this.m.turnsWithoutSong = 2;
		{
			this.m.songStacks = 0;
			this.m.turnsWithoutSong = 0;
			this.removeSelf();
			return;
		}
	}

	function onCombatFinished()
	{
		this.m.songStacks = 0;
		this.m.turnsWithoutSong = 0;
		this.removeSelf();
	}
});
