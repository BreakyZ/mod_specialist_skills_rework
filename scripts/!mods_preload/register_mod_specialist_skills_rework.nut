::ModSpecialistSkillsRework <- {
	ID = "mod_specialist_skills_rework",
	Name = "Mod Specialist Skills Rework",
	Version = "1.0.8"
};

::ModSpecialistSkillsRework.HooksMod <- ::Hooks.register(::ModSpecialistSkillsRework.ID, ::ModSpecialistSkillsRework.Version, ::ModSpecialistSkillsRework.Name);


// add which mods are needed to run this mod
::ModSpecialistSkillsRework.HooksMod.require("mod_msu >= 1.2.6", "mod_modern_hooks");

// like above you can add as many parameters to determine the queue order of the mod before adding the parameter to run the callback function. 
::ModSpecialistSkillsRework.HooksMod.queue(">mod_msu", ">mod_legends", ">mod_sellswords", function()
{
	// define mod class of this mod
	::ModSpecialistSkillsRework.Mod <- ::MSU.Class.Mod(::ModSpecialistSkillsRework.ID, ::ModSpecialistSkillsRework.Version, ::ModSpecialistSkillsRework.Name);

	// load hook files
	::include("specialist_skills_hooks/load.nut");
}, ::Hooks.QueueBucket.Normal);