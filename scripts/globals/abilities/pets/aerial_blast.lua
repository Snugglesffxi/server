-----------------------------------
-- Aerial Blast
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/monstertpmoves")

-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local level = player:getMainLvl() * 2

    if(player:getMP()<level) then
       return 87, 0
    end

    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill, master)
    local dINT = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))

    local level = pet:getMainLvl()
    local damage = 48 + (level * 8)
    damage = damage + (dINT * 1.5)
    damage = MobMagicalMove(pet, target, skill, damage, xi.magic.ele.WIND, 1, TP_NO_EFFECT, 0)
    damage = mobAddBonuses(pet, target, damage.dmg, xi.magic.ele.WIND)
    damage = AvatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, 1)

    master:setMP(0)
    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.WIND)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return ability_object
