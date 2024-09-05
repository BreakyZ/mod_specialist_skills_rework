local instruments = [
	"lute",
	"named/named_lute",
	"barbarians/drum_item"
];
foreach (instrument in instruments)
{
	::ModSpecialistSkillsRework.HooksMod.hook("scripts/items/weapons/" + instrument, function( q )
	{	
		q.onEquip = @(__original) function()
		{
			__original();

			this.addSkill(this.new("scripts/skills/actives/legend_drums_of_war_skill"));
			this.addSkill(this.new("scripts/skills/actives/legend_drums_of_life_skill"));
		}
	});
}
