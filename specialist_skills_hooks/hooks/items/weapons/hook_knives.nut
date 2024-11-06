local daggers = [
	"knife",
	"dagger",
	"legend_katar",
	"legend_shiv",
	"rondel_dagger",
	"legendary/obsidian_dagger",
	"oriental/qatal_dagger",
	"named/named_qatal_dagger",
	"named/named_dagger"
];
if (::Is_SSU_Exist)
{
	daggers.extend([
		"special/ssu_legendary_dagger",
		"named/named_katar"
	]);
};
foreach (dagger in daggers)
{
	::ModSpecialistSkillsRework.HooksMod.hook("scripts/items/weapons/" + dagger, function( q )
	{	
		q.m.hasDeathblow <- false;
	
		q.onEquip = @(__original) function()
		{
			__original();
			local skills = this.getContainer().getActor().getSkills();
			if (skills.hasSkill("actives.deathblow"))
			{
				this.m.hasDeathblow = true;
				skills.removeByID("actives.deathblow");
			}
			local skill = this.new("scripts/skills/actives/deathblow_skill");
			skill.setItem(this);
			this.addSkill(skill);
		}
	});
};
