-----------------------------------
--  Cryo_Jet
--  Description:
--  Type: Magical
--  additional effect : Paralyze
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    -- skillList  54 = Omega
    -- skillList 727 = Proto-Omega
    -- skillList 728 = Ultima
    -- skillList 729 = Proto-Ultima
    -- local skillList = mob:getMobMod(xi.mobMod.SKILL_LIST)
    -- local mobhp = mob:getHPP()
    -- local phase = mob:getLocalVar("battlePhase")

    if mob:getLocalVar("nuclearWaste") == 1 then
        return 0
    end

    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 3, 60)

    local dmgmod = 2
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, xi.magic.ele.ICE, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    if target:hasStatusEffect(xi.effect.ELEMENTALRES_DOWN) then
        target:delStatusEffectSilent(xi.effect.ELEMENTALRES_DOWN)
    end
    mob:setLocalVar("nuclearWaste", 0)
    return dmg
end
return mobskill_object
