-----------------------------------
-- Area: Bastok Mines
--  NPC: Mariadok
-- Type: Weather Reporter
-----------------------------------
require("scripts/settings/main")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(2, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
