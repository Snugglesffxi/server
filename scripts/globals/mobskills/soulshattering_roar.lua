-----------------------------------
-- Soulshattering Roar
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
    local typeEffect = xi.effect.TERROR
    -- local duration = 10
    local dmgmod = 2.0

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 30)

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.DARK, dmgmod,TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)

    -- TODO: Temporary immunity to a single weapon damage type

    return dmg
end

return mobskill_object
