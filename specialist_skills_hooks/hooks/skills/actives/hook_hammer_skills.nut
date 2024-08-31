foreach (hammer_skill in [
	"hammer",
	"crush_armor",
])
{
	::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/" + hammer_skill, function( q )
	{	
		q.onAnySkillUsed = @( __original ) function( _skill, _targetEntity, _properties )
		{
			if (_skill != this) return;
			_properties.DamageMinimum = this.Math.max(_properties.DamageMinimum, 10);
			_properties.DamageMinimum += this.getBonus();

		}

		q.getBonus <- function()
		{
			local actor = this.getContainer().getActor();
			if (!(actor.getFlags().has("BlacksmithSpecialist"))) return 0;

			local items = actor.getItems();
			local condition = 0

			condition += items.getItemAtSlot(this.Const.ItemSlot.Head) != null ? items.getItemAtSlot(this.Const.ItemSlot.Head).getConditionMax() : 0;
			condition += items.getItemAtSlot(this.Const.ItemSlot.Body) != null ? items.getItemAtSlot(this.Const.ItemSlot.Body).getConditionMax() : 0;

			return this.Math.floor(0.01 * condition);
		}

		q.getTooltip = @( __original ) function ()
		{
			local ret = this.getDefaultTooltip();
			local bonus = this.Math.max(this.getContainer().getActor().getCurrentProperties().DamageMinimum, 10);
			bonus += this.getBonus();
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Always inflicts at least [color=" + this.Const.UI.Color.DamageValue + "]" + bonus + "[/color] damage to hitpoints, regardless of armor"
			});
			return ret;
		}
	});
}