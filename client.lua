local radial_menu = class("radial_menu", vRP.Extension)
radial_menu.event = {}
radial_menu.tunnel = {}

local function PoliceItems(self)
  exports['ox_lib']:addRadialItem({
    {
      id = 'police',
      label = 'Police Actions',
      icon = 'shield',  -- Corrected typo here
      menu = 'police_menu'
    }
  })

  exports['ox_lib']:registerRadial({
    id = 'police_menu',
    items = {
      {
        label = 'Handcuff',
        icon = 'handcuffs',
        onSelect = function()
          self.remote._HandCuff(self)
        end
      }
    }
  })
end

local function removePoliceItems()
  exports['ox_lib']:removeRadialItem('police')
end

function radial_menu:__construct()
  vRP.Extension.__construct(self)

  self.isPolice = false
  -- General Items in Menu.
  exports['ox_lib']:addRadialItem({
    {
      id = 'calladmin',
      label = 'Call Admin',
      icon = 'exclamation-triangle',
      onSelect = function()
        self.remote._callAdmin()
      end
    },
    {
      id = 'givemoney',
      label = 'Give Money',
      icon = 'money-bill-wave',
      onSelect = function()
        self.remote._GiveMoney()
      end
    }
  })

  Citizen.CreateThread(function()
    while true do
      --print("Checking police status...")
      local isPolice = self.remote.isPolice()
      if isPolice and not self.isPolice then
        --print("Player is police.")
        PoliceItems(self)
        self.isPolice = true
      elseif not isPolice and not self.isPolice then
        --print("Player is not police.")
        self.isPolice = false
      elseif not isPolice and self.isPolice then
        removePoliceItems(self)
        self.isPolice = false
        --print("Player is no longer police.")
      end
      Citizen.Wait(2500)
    end
  end)
end

function radial_menu:toggleDrag(id, self)
  print("Toggling drag... "..id)

end






























vRP:registerExtension(radial_menu)
