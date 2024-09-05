// new perk added
foreach (file in ::IO.enumerateFiles("specialist_skills_hooks/config/"))
	::include(file);

# breditor patches
if (::Is_BR_Exist)
	foreach (file in ::IO.enumerateFiles("specialist_skills_hooks/hooks_breditor"))
		::include(file);

foreach (file in ::IO.enumerateFiles("specialist_skills_hooks/hooks/"))
	::include(file);

if (::Is_World_Editor_Exists)
	foreach (file in ::IO.enumerateFiles("specialist_skills_hooks/hooks_world_editor"))
		::include(file);

if (!::Is_SSU_Exist)
	foreach (file in ::IO.enumerateFiles("specialist_skills_hooks/hooks_throwing_skills"))
		::include(file);

// update the perk tooltips
::Const.Perks.updatePerkGroupTooltips();