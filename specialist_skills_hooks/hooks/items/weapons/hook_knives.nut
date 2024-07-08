daggers = [
	"knife",
	"dagger",
	"legend_katar",
	"legend_redback_dagger",
	"legend_shiv",
	"rondel_dagger",
	"legendary/obsidian_dagger",
	"named/named_dagger",
	"named/named_katar"
]
if (Is_SSU_Exist)
{
	daggers.extend(["special/ssu_legendary_dagger"])
}
foreach (dagger in daggers)
{
	::ModReworkCca.HooksMod.hook("scripts/items/weapons/" + dagger, function( q )
	{	
		q.onEquip = @(__original) function()
		{
			__original();

			this.addSkill(this.new("scripts/skills/actives/deathblow_skill"));
		}
	});
}
