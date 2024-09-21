::ModSpecialistSkillsRework.HooksMod.hook("scripts/scenarios/world/legends_troupe_scenario", function( q )
{
	q.onSpawnAssets = @(__original) function()
	{
		local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 4; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"legend_illusionist_background"
		]);
		bros[0].getBackground().m.RawDescription = "{%name% learned how to entertain on the streets, using slight of hand and magic tricks to dupe unwitting punters out of their coin. Illusion is easier with a distraction, so the choice to join others was easy.}";
		bros[0].m.PerkPoints = 2;
		bros[0].m.LevelUps = 2;
		bros[0].m.Level = 3;
		bros[0].setPlaceInFormation(13);
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_legend_leap"));
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_legend_push"));
		bros[0].m.PerkPointsSpent += 1;
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.Const.World.Common.pickHelmet([[1, "jesters_hat"]]));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/legend_slingstaff"));
		bros[1].setStartValuesEx(["minstrel_background"],true,0);
		bros[1].getBackground().m.RawDescription = "{%name% worked providing entertainment at inns around the country, but the bar fights and road bandits make it no life for a solo artist. Joining with others was for safety as much as the show.}";
		bros[1].setPlaceInFormation(12);
		bros[1].getSkills().add(this.new("scripts/skills/perks/perk_legend_leap"));
		bros[1].getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_lute_skill"));

		bros[1].m.PerkPointsSpent += 1;
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.Const.World.Common.pickHelmet([[1, "named/jugglers_hat"]]));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/lute"));
		bros[2].setStartValuesEx(["minstrel_background"],true,1);
		bros[2].getBackground().m.RawDescription = "{%name% has been in the court of a local noble for years, but the same audience every night grows tiresome. It was time to find a band, hit the road and find some new audiences for their art.}";
		bros[2].improveMood(1.0, "Got the band back together");
		bros[2].setPlaceInFormation(4);
		bros[2].m.PerkPoints = 3;
		bros[2].m.LevelUps = 3;
		bros[2].m.Level = 4;
		bros[2].getSkills().add(this.new("scripts/skills/perks/perk_legend_leap"));
		bros[2].getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_lute_skill"));
		bros[2].m.PerkPointsSpent += 1;
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.Const.World.Common.pickHelmet([[1, "named/jugglers_hat"]]));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/legend_drum"));
		bros[3].setStartValuesEx([
			"juggler_background"
		]);
		bros[3].getBackground().m.RawDescription = "{%name% was juggling and throwing knives in markets, and agreed to join the troupe to improve the show with the skills of others}";
		bros[3].setPlaceInFormation(13);
		bros[3].m.PerkPoints = 1;
		bros[3].m.LevelUps = 1;
		bros[3].m.Level = 2;
		bros[3].getSkills().add(this.new("scripts/skills/perks/perk_legend_leap"));
		bros[3].getSkills().add(this.new("scripts/skills/perks/perk_legend_push"));
		bros[3].m.PerkPointsSpent += 1;
		local items = bros[3].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.Const.World.Common.pickHelmet([[1, "named/jugglers_padded_hat"]]));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/greenskins/orc_javelin"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/legend_pie_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/mead_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/legend_drum"));
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/greenskins/goblin_spiked_balls"));
	}
});
