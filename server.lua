--original code at bottom
local htmlEntities = module("lib/htmlEntities")
local lang = vRP.lang

local radial_menu = class("radial_menu", vRP.Extension)

function radial_menu:__construct()
  vRP.Extension.__construct(self)
end

-- TUNNEL
radial_menu.tunnel = {}


function radial_menu:giveMoney()
  local user = vRP.users_by_source[source]
  local nplayer = vRP.EXT.Base.remote.getNearestPlayer(user.source, 10)

  if nplayer then
    local nuser = vRP.users_by_source[nplayer]
    if nuser then
      -- Prompt for amount
      local amount = parseInt(user:prompt(lang.money.give.prompt(), "")) or 0
      if amount > 0 and user:tryPayment(amount) then
        nuser:giveWallet(amount)
        vRP.EXT.Base.remote._notify(user.source, lang.money.given({amount}))
        vRP.EXT.Base.remote._notify(nuser.source, lang.money.received({amount}))
      else
        vRP.EXT.Base.remote._notify(user.source, lang.money.not_enough())
      end
    else
      vRP.EXT.Base.remote._notify(user.source, lang.common.no_player_near())
    end
  else
    vRP.EXT.Base.remote._notify(user.source, lang.common.no_player_near())
  end
end

function radial_menu:callAdmin()
  local user = vRP.users_by_source[source]

  if not user:hasPermission("player.calladmin") then
    vRP.EXT.Base.remote._notify(user.source, "You do not have permission to call an admin.")
    return
  end

  local desc = user:prompt(lang.admin.call_admin.prompt(), "") or ""
  local answered = false

  local admins = {}
  for _, user in pairs(vRP.users) do
    if user:isReady() and user:hasPermission("admin.tickets") then
      table.insert(admins, user)
    end
  end

  for _, admin in pairs(admins) do
    async(function()
      local ok = admin:request(lang.admin.call_admin.request({user.id, htmlEntities.encode(desc)}), 60)
      if ok and not answered then
        answered = true
        vRP.EXT.Base.remote._notify(user.source, "An Admin has claimed your ticket.")
        vRP.EXT.Base.remote._teleport(admin.source, vRP.EXT.Base.remote.getPosition(user.source))
      elseif ok then
        vRP.EXT.Base.remote._notify(admin.source, "Ticket is already claimed.")
      end
    end)
  end
end

function radial_menu:isPolice()
  local users = vRP.users
  local group = vRP.EXT.Group:getUsersByGroup('police')
  for k, v in pairs(group) do
    if v.source == source then
      return true
    else
      return false
    end
  end
end


radial_menu.tunnel.giveMoney = radial_menu.giveMoney
radial_menu.tunnel.callAdmin = radial_menu.callAdmin
radial_menu.tunnel.isPolice = radial_menu.isPolice
vRP:registerExtension(radial_menu)
