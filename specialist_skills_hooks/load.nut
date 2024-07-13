// new perk added
foreach (file in ::IO.enumerateFiles("specialist_skills_hooks/config/"))
{
	::include(file);
}

# breditor patches
if (::Is_BR_Exist)
	foreach (file in ::IO.enumerateFiles("specialist_skills_hooks/hooks_breditor"))
		::include(file);

foreach (file in ::IO.enumerateFiles("specialist_skills_hooks/hooks/"))
{
	::include(file);
}


// update the perk tooltips
::Const.Perks.updatePerkGroupTooltips();