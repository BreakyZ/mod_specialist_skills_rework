local bombs = [
	"acid_flask_item",
	"daze_bomb_item",
	"fire_bomb_item",
	"holy_water_item",
	"smoke_bomb_item"
];
local bomb_skill = [
	"throw_acid_flask",
	"throw_daze_bomb",
	"throw_fire_bomb",
	"throw_holy_water",
	"throw_smoke_bomb"
];
for (local i = 0; i < bombs.len(); ++i)
{
	::ModSpecialistSkillsRework.HooksMod.hook("scripts/items/tools/" + bomb, function( q )
	{	
		q.onPutIntoBag <- function()
		{
			item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			if (!(item.getID() == "weapon.nomad_sling" || item.getID() == "weapon.named_northern_sling" item.getID() == "weapon.legend_slingstaff"))
				return;

			local skill = this.new("scripts/skills/actives/" + bomb_skill[i]);
			skill.setItem(this);
			skill.m.RangeMax = 8;
			skill.m.RangeMin = 3;
			skill.m.ActionPointCost = 6;
			skill.m.Delay = 100;
			this.addSkill(skill);
		}
	});
}
