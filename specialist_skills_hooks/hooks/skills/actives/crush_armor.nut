::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/crush_armor", function( q )
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
		local p = this.getContainer().getActor().getCurrentProperties();
		local f = p.IsSpecializedInHammers ? 2.0 : 1.5;
		local damage_armor_min = this.Math.floor(p.DamageRegularMin * p.DamageArmorMult * f * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_armor_max = this.Math.floor(p.DamageRegularMax * p.DamageArmorMult * f * p.DamageTotalMult * p.MeleeDamageMult);
		local ret = this.getDefaultUtilityTooltip();

		if (damage_armor_max > 0)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + damage_armor_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_armor_max + "[/color] damage to armor"
			});
		}

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