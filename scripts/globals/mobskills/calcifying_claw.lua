-----------------------------------
-- Calcifying Claw
-- Deals damage to a single target. Additional effect: Petrification, Knockback
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target,mob,skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.0
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    MobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 50, 0, 30)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    return dmg
end

return mobskill_object
