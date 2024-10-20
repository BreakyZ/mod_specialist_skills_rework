::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/skill", function ( q )
{
	q.getNoSpecialistWeaponTooltip <- function()
	{
		local tooltip = this.skill.getTooltip()
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "This character is not using the specialist weapon or hasn\'t accumulated a bonus yet"
		});

		return tooltip;
	}

	q.getDefaultSpecialistSkillDescription <- function(_weapon = "ERROR THIS SHOULD ALWAYS BE SPECIFIED")
	{
		return format("Gain bonuses to your attack skill and damage when using %s.", _weapon);
	}
});