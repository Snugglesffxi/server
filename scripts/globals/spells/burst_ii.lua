-----------------------------------
-- Spell: Burst II
-- Deals lightning damage to an enemy and lowers its resistance against earth.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local spellParams = {}
    spellParams.hasMultipleTargetReduction = false
    spellParams.resistBonus = 1.0
    spellParams.V = 710
    spellParams.V0 = 800
    spellParams.V50 = 900
    spellParams.V100 = 1000
    spellParams.V200 = 1200
    spellParams.M = 2
    spellParams.M0 = 2
    spellParams.M50 = 2
    spellParams.M100 = 2
    spellParams.M200 = 2
    spellParams.I = 780
    spellParams.bonusmab = caster:getMerit(xi.merit.ANCIENT_MAGIC_ATK_BONUS)
    spellParams.AMIIburstBonus = caster:getMerit(xi.merit.ANCIENT_MAGIC_BURST_DMG)/100

    -- no point in making a separate function for this if the only thing they won't have in common is the name
    handleNinjutsuDebuff(caster, target, spell, 30, 10, xi.mod.EARTH_RES)

    return doElementalNuke(caster, spell, target, spellParams)
end

return spell_object
