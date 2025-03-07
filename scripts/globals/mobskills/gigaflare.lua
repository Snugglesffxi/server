-----------------------------------
--  Gigaflare
--  Family: Bahamut
--  Description: Deals massive Fire damage to enemies within a fan-shaped area.
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range:
--  Notes: Used by Bahamut when at 10% of its HP, and can use anytime afterwards at will.
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    local mobhp = mob:getHPP()

    if (mobhp <= 10) then -- set up Gigaflare for being called by the script again.
        mob:setLocalVar("GigaFlare", 0)
        mob:SetMobAbilityEnabled(false) -- disable mobskills/spells until Gigaflare is used successfully (don't want to delay it/queue Megaflare)
        mob:SetMagicCastingEnabled(false)
    end

    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    mob:setLocalVar("GigaFlare", 1) -- When set to 1 the script won't call it.
    mob:setLocalVar("tauntShown", 0)
    mob:SetMobAbilityEnabled(true) -- enable the spells/other mobskills again
    mob:SetMagicCastingEnabled(true)
    if (bit.band(mob:getBehaviour(), xi.behavior.NO_TURN) == 0) then -- re-enable noturn
        mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    end

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*15, xi.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskill_object
