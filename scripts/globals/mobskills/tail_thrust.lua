-----------------------------------
--  Tail Thrust
--  Family: Hpemde
--  Description: Strikes a single target with its tail.
--  Type: Physical
--  Utsusemi/Blink absorb: One shadow
--  Range: Unknown
--  Notes: Additional effect - paralyze
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 2.4
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    local typeEffect = xi.effect.PARALYSIS
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 15, 0, 120)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    return dmg
end

return mobskill_object
