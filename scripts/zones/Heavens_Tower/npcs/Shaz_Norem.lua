-----------------------------------
-- Area: Heavens Tower
--  NPC: Shaz Norem
-- Type: Standard NPC
-- !pos 2.805 -47.999 -15.083 242
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local missionStatus = player:getMissionStatus(player:getNation())

    if
        (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.MOON_READING and missionStatus >= 3) or
        player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MOON_READING)
    then
        player:startEvent(401)
    else
        player:startEvent(91)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 401 then
        player:setCharVar("FixatedYagudo", 0)
    end
end

return entity
