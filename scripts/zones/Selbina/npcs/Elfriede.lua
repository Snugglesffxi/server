-----------------------------------
-- Area: Selbina
--  NPC: Elfriede
-- Involved In Quest: The Tenshodo Showdown
-- !pos 61 -15 10 248
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 4569) and player:getCharVar("theTenshodoShowdownCS") == 3 then -- Quadav Stew
        player:startEvent(10004, 0, xi.ki.TENSHODO_ENVELOPE, 4569)
    end
end

entity.onTrigger = function(player, npc)
    local theTenshodoShowdownCS = player:getCharVar("theTenshodoShowdownCS")

    if theTenshodoShowdownCS == 2 then
        player:startEvent(10002, 0, xi.ki.TENSHODO_ENVELOPE, 4569) -- During Quest "The Tenshodo Showdown"
        player:setCharVar("theTenshodoShowdownCS", 3)
    elseif theTenshodoShowdownCS == 3 then
        player:startEvent(10003, 0, 0, 4569)
    else
        player:startEvent(25) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 10004 then
        player:setCharVar("theTenshodoShowdownCS", 4)
        player:delKeyItem(xi.ki.TENSHODO_ENVELOPE)
        npcUtil.giveKeyItem(player, xi.ki.SIGNED_ENVELOPE)
        player:confirmTrade()
    end
end

return entity
