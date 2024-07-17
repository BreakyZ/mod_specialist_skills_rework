::ModSpecialistSkillsRework <- {
	ID = "mod_specialist_skills_rework",
	Name = "Mod Specialist Skills Rework",
	Version = "1.3.3"
};

::ModSpecialistSkillsRework.HooksMod <- ::Hooks.register(::ModSpecialistSkillsRework.ID, ::ModSpecialistSkillsRework.Version, ::ModSpecialistSkillsRework.Name);


// add which mods are needed to run this mod
::ModSpecialistSkillsRework.HooksMod.require("mod_msu >= 1.2.6", "mod_modern_hooks");

::ModSpecialistSkillsRework.HooksMod.conflictWith("mod_legends_PTR");

// like above you can add as many parameters to determine the queue order of the mod before adding the parameter to run the callback function. 
::ModSpecialistSkillsRework.HooksMod.queue(">mod_msu", ">mod_legends", ">mod_sellswords", ">mod_breditor", ">mod_fantasybro_rotu", ">mod_legends_PTR", function()
{
	// define mod class of this mod
	::ModSpecialistSkillsRework.Mod <- ::MSU.Class.Mod(::ModSpecialistSkillsRework.ID, ::ModSpecialistSkillsRework.Version, ::ModSpecialistSkillsRework.Name);
	::ModSpecialistSkillsRework.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/BreakyZ/battle_brothers_specialist_skills_rework");
	::ModSpecialistSkillsRework.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

	local page = ::ModSpecialistSkillsRework.Mod.ModSettings.addPage("Specialist Skill Rework");
	page.addElement(::MSU.Class.BooleanSetting("SSUStyle", false, "SSU style", "Picking this will enable SSU style specialist skill scaling - weekly growth."));

	if (!("Is_BR_Exist" in this.getroottable())) ::Is_BR_Exist <- ::mods_getRegisteredMod("mod_breditor") != null;
	if (!("Is_SSU_Exist" in this.getroottable())) ::Is_SSU_Exist <- ::mods_getRegisteredMod("mod_sellswords") != null;
	// load hook files
	::include("specialist_skills_hooks/load.nut");
}, ::Hooks.QueueBucket.Normal);