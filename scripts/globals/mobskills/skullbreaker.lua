-----------------------------------
-- Skullbreaker
--
-- Description: Lowers enemy's INT. Chance of lowering INT varies with TP.
-- Type: Physical
-- Utsusemi/Blink absorb: 1 Shadow
-- Range: Melee
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    mob:messageBasic(xi.msg.basic.READIES_WS, 0, 165)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.0
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT, 1.1, 1.2, 1.3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if (math.random(1, 100) < skill:getTP()/3) then
        MobPhysicalStatusEffectMove(mob, target, skill, xi.effect.INT_DOWN, 10, 3, 120)
    end

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskill_object
