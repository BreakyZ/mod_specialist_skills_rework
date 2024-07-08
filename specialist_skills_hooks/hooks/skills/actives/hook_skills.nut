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

			condition += items.getItemAtSlot(this.Const.ItemSlot.Head) ? items.getItemAtSlot(this.Const.ItemSlot.Head).getConditionMax() : 0;
			condition += items.getItemAtSlot(this.Const.ItemSlot.Body) ? items.getItemAtSlot(this.Const.ItemSlot.Body).getConditionMax() : 0;

			return this.Math.floor(0.01 * condition);
		}

		q.getTooltip = @( __original ) function ()
		{
			local ret = this.getDefaultTooltip();
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Always inflicts at least [color=" + this.Const.UI.Color.DamageValue + "]" + 10 + getBonus() + "[/color] damage to hitpoints, regardless of armor"
			});
			return ret;
		}
	});
}
foreach (reload_skill in [
	"reload_bolt",
	"reload_handgonne_skill",
])
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/" + reload_skill, function ( q )
{
	q.onAfterUpdate = @( __original ) function( _properties )
	{
		__original( _properties );
		local actor = this.getContainer().getActor();
		if (actor.getFlags().has("inventorSpecialist"))
		{
			this.m.ActionPointCost -= 1;
		}
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/legend_sling_heavy_stone_skill", function ( q )
{
	q.onAfterUpdate = @( __original) function ( _properties )
	{
		this.m.MaxRange = this.m.Item.getRangeMax() + (_properties.IsSpecializedInSlings ? 1 : 0);
		this.m.AdditionalAccuracy = _properties.IsSpecializedInSlings ? 0 : -5;
		this.m.AdditionalHitChance = _properties.IsSpecializedInSlings ? -2 : -4;
		this.m.FatigueCostMult = _properties.IsSpecializedInSlings ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		if (this.getContainer().hasSkill("perk.legend_mastery_slings") && this.getContainer().hasSkill("perk.legend_specialist_sling_skill"))
		{
			this.m.ActionPointCost = 7;
			this.m.FatigueCost = 25;
		}
		else if (this.getContainer().hasSkill("perk.legend_specialist_sling_skill"))
		{
			this.m.ActionPointCost = 6;
			this.m.FatigueCost = 21;
		}
	}

	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			// replaces the damage portion as it'll be handled in the perk
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}
});
::ModSpecialistSkillsRework.HooksMod.hook("scripts/skills/actives/deathblow_skill", function( q ) 
{
	q.getTooltip = @(__original) function()
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local ret = this.getDefaultTooltip();

		if (actor.getFlags().has("knifeSpecialist") && (item.getID() == "weapon.qatal_dagger" || item.getID() == "weapon.named_qatal_dagger"))
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]50%[/color] more damage against and ignores additional [color=" + this.Const.UI.Color.DamageValue + "]30%[/color] armor of targets that have the Dazed, Stunned, Sleeping, Rooted, Distracted, Trapped in Web or Trapped in Net status effects."
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]33%[/color] more damage against and ignores additional [color=" + this.Const.UI.Color.DamageValue + "]20%[/color] armor of targets that have the Dazed, Stunned, Sleeping, Rooted, Distracted, Trapped in Web or Trapped in Net status effects."
			});
		}
		return ret;
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();
		if (actor == null) return true;
		
		local item = actor.getMainhandItem()

		switch (true)
		{
			case item == null:
				return true;
			case !item.isWeaponType(this.Const.Items.WeaponType.Dagger):
				return true;
			case item.getID() == "weapon.qatal_dagger" || item.getID() == "weapon.named_qatal_dagger":
				return false;
			case actor.getFlags().has("knifeSpecialist"):
				return false;

		return false;
	}

	q.onAnySkillUsed = @(__original) function ( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();
		local targetStatus = _targetEntity.getSkills();

		if (_skill == this && (targetStatus.hasSkill("effects.dazed") || targetStatus.hasSkill("effects.stunned") || targetStatus.hasSkill("effects.sleeping") || targetStatus.hasSkill("effects.net") || targetStatus.hasSkill("effects.distracted") || targetStatus.hasSkill("effects.web") || targetStatus.hasSkill("effects.rooted") || targetStatus.hasSkill("effects.legend_grappled") || targetStatus.hasSkill("effects.shellshocked") || targetStatus.hasSkill("effects.chilled") || targetStatus.hasSkill("effects.staggered")))
		{
			if (actor.getFlags().has("knifeSpecialist") && (item.getID() == "weapon.qatal_dagger" || item.getID() == "weapon.named_qatal_dagger"))
			{
				_properties.DamageTotalMult *= 1.5;
				_properties.DamageDirectAdd += 0.3;
			}
			else
			{
				_properties.DamageTotalMult *= 1.33;
				_properties.DamageDirectAdd += 0.2;
			}
		}
	}
});