local radial_menu = class("radial_menu", vRP.Extension)
radial_menu.event = {}
radial_menu.tunnel = {}

local function PoliceItems(self)
  exports["ox_lib"]:addRadialItem(
    {
      {
        id = "police",
        label = "Police Actions",
        icon = "shield", -- Corrected typo here
        menu = "police_menu"
      }
    }
  )

  exports["ox_lib"]:registerRadial(
    {
      id = "police_menu",
      items = {
        {
          label = "Handcuff",
          icon = "handcuffs",
          onSelect = function()
            self.remote._HandCuff(self)
          end
        }
      }
    }
  )
end

local function removePoliceItems()
  exports["ox_lib"]:removeRadialItem("police")
end

local function VehicleMenu(self, nvehicle)
  local isEngineOn = true
  local isLocked = false

  exports["ox_lib"]:addRadialItem(
    {
      {
        id = "vehicle",
        label = "Vehicle Actions",
        icon = "car",
        menu = "vehicle_menu"
      }
    }
  )

  exports["ox_lib"]:registerRadial(
    {
      id = "vehicle_menu",
      items = {
        {
          label = "Lock/Unlock",
          icon = "lock",
          onSelect = function()
            isLocked = not isLocked
            vRP.EXT.Garage:vc_toggleLock(nvehicle)
            if isLocked then
              vRP.EXT.Base:notify("Vehicle is now locked.")
            else
              vRP.EXT.Base:notify("Vehicle is now unlocked.")
            end
          end
        },
        {
          label = "Engine On/Off",
          icon = "power-off",
          onSelect = function()
            isEngineOn = not isEngineOn
            vRP.EXT.Garage:vc_toggleEngine(nvehicle)
            if isEngineOn then
              vRP.EXT.Base:notify("Engine is now on.")
            else
              vRP.EXT.Base:notify("Engine is now off.")
            end
          end
        },
        {
          id = "doors",
          label = "Doors",
          icon = "door-open",
          menu = "door_menu"
        }
      }
    }
  )

  exports["ox_lib"]:registerRadial(
    {
      id = "door_menu",
      items = {
        {
          label = "Driver Door",
          icon = "door-open",
          keepOpen = true,
          onSelect = function()
            vRP.EXT.Garage:vc_openDoor(nvehicle, 0)
          end
        },
        {
          label = "Passenger Door",
          icon = "door-open",
          keepOpen = true,
          onSelect = function()
            vRP.EXT.Garage:vc_openDoor(nvehicle, 1)
          end
        },
        {
          label = "Rear Left Door",
          icon = "door-open",
          keepOpen = true,
          onSelect = function()
            vRP.EXT.Garage:vc_openDoor(nvehicle, 2)
          end
        },
        {
          label = "Rear Right Door",
          icon = "door-open",
          keepOpen = true,
          onSelect = function()
            vRP.EXT.Garage:vc_openDoor(nvehicle, 3)
          end
        },
        {
          label = "Hood",
          icon = "car",
          keepOpen = true,
          onSelect = function()
            vRP.EXT.Garage:vc_openDoor(nvehicle, 4)
          end
        },
        {
          label = "Trunk",
          icon = "suitcase",
          keepOpen = true,
          onSelect = function()
            vRP.EXT.Garage:vc_openDoor(nvehicle, 5)
          end
        }
      }
    }
  )
end

function radial_menu:__construct()
  vRP.Extension.__construct(self)

  self.isPolice = false
  -- General Items in Menu.
  self.isNearVehicle = false

  exports["ox_lib"]:addRadialItem(
    {
      {
        id = "calladmin",
        label = "Call Admin",
        icon = "exclamation-triangle",
        onSelect = function()
          self.remote._callAdmin()
        end
      },
      {
        id = "givemoney",
        label = "Give Money",
        icon = "money-bill-wave",
        onSelect = function()
          self.remote._GiveMoney()
        end
      }
    }
  )
  Citizen.CreateThread(
    function()
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
    end
  )

  Citizen.CreateThread(
    function()
      while true do
        --print("Checking if player is near any owned vehicles...")
        local nVehicle = vRP.EXT.Garage:getNearestOwnedVehicle(7)
        if nVehicle ~= nil and not self.isNearVehicle then
          --print("Player is near an owned vehicle.")
          VehicleMenu(self, nVehicle)
          self.isNearVehicle = true
        elseif nVehicle == nil and not self.isNearVehicle then
          --print("Player is not near any owned vehicles.")
          self.isNearVehicle = false
        elseif nVehicle == nil and self.isNearVehicle then
          --print("Player is no longer near any owned vehicles.")
          exports["ox_lib"]:removeRadialItem("vehicle")
          self.isNearVehicle = false
        end
        Citizen.Wait(2500)
      end
    end
  )
end

vRP:registerExtension(radial_menu)
