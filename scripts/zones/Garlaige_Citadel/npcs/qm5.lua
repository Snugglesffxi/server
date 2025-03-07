-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm5 (???)
-- Involved in Quest: Hitting the Marquisate (THF AF3)
-- !pos -259.927 -5.500 194.410 200
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.BOMB_INCENSE) and player:getCharVar("hittingTheMarquisateHagainCS") == 3 then
        player:messageSpecial(ID.text.PRESENCE_FROM_CEILING)
        player:startEvent(51, xi.keyItem.BOMB_INCENSE)
    else
        player:messageSpecial(ID.text.HOLE_IN_THE_CEILING) -- Default
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 51 and option == 1 then
        player:messageSpecial(ID.text.THE_PRESENCE_MOVES + 2) -- Presence moved south.
        player:setCharVar("hittingTheMarquisateHagainCS", 4)
    end
end

return entity
