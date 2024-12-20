local staves = [
	"legend_mystic_staff",
	"legend_staff_vala",
	"legend_staff_gnarled",
	"legend_staff",
	"legend_tipstaff",
	"legend_mystic_staff",
];
if (::Is_SSU_Exist)
{
	staves.extend([
		"dryad/dryad_staff",
		"greenskins/cr_orc_staff"
		"named/named_staff",
	])
};
if (::Is_MC_Exist)
{
	staves.push("named/nggh_mod_named_staff")
}
foreach (staff in staves)
{
	::ModSpecialistSkillsRework.HooksMod.hook("scripts/items/weapons/" + staff, function( q )
	{	
		q.onEquip = @(__original) function()
		{
			__original();

			this.addSkill(this.new("scripts/skills/actives/legend_staff_riposte"));
		}
	});
}
