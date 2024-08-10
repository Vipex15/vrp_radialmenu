local radial_menu = class("radial_menu", vRP.Extension)
radial_menu.event = {}
radial_menu.tunnel = {}

local function PoliceItems()
  exports['ox_lib']:addRadialItem({
    {
      id = 'police',
      label = 'Police Actions',
      icon = 'shielf',
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
          exports['TSLib']:Handcuff()
        end
      },
      {
        label = 'Remove Cuffs',
        icon = 'handcuffs',
        onSelect = function()
          exports['TSLib']:RemoveHandcuffs()
        end
      },
      {
        label = 'Put in Vehicle',
        icon = 'car',
        onSelect = function()
          exports['TSLib']:ForceIntoVehicle()
        end
      },
      {
        label = 'Take From Vehicle',
        icon = 'car',
        onSelect = function()
          exports['TSLib']:ForceOutOfVehicle()
        end
      },
      {
        label = 'Drag',
        icon = 'person-carry',
        onSelect = function()
          exports['TSLib']:DragPlayer()
        end
      },
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
        PoliceItems()
        self.isPolice = true
      elseif not isPolice and not self.isPolice then
        --print("Player is not police.")
        self.isPolice = false
      elseif not isPolice and self.isPolice then
        removePoliceItems()
        self.isPolice = false
        --print("Player is no longer police.")
      end
      Citizen.Wait(2500)
    end
  end)
end

vRP:registerExtension(radial_menu)
