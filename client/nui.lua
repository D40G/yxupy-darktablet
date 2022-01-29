
--[[
      _____                                            _____                    _____                _____          
     |\    \                 ______                   /\    \                  /\    \              |\    \         
     |:\____\               |::|   |                 /::\____\                /::\    \             |:\____\        
     |::|   |               |::|   |                /:::/    /               /::::\    \            |::|   |        
     |::|   |               |::|   |               /:::/    /               /::::::\    \           |::|   |        
     |::|   |               |::|   |              /:::/    /               /:::/\:::\    \          |::|   |        
     |::|   |               |::|   |             /:::/    /               /:::/__\:::\    \         |::|   |        
     |::|   |               |::|   |            /:::/    /               /::::\   \:::\    \        |::|   |        
     |::|___|______         |::|   |           /:::/    /      _____    /::::::\   \:::\    \       |::|___|______  
     /::::::::\    \  ______|::|___|___ ____  /:::/____/      /\    \  /:::/\:::\   \:::\____\      /::::::::\    \ 
    /::::::::::\____\|:::::::::::::::::|    ||:::|    /      /::\____\/:::/  \:::\   \:::|    |    /::::::::::\____\
   /:::/~~~~/~~      |:::::::::::::::::|____||:::|____\     /:::/    /\::/    \:::\  /:::|____|   /:::/~~~~/~~      
  /:::/    /          ~~~~~~|::|~~~|~~~       \:::\    \   /:::/    /  \/_____/\:::\/:::/    /   /:::/    /         
 /:::/    /                 |::|   |           \:::\    \ /:::/    /            \::::::/    /   /:::/    /          
/:::/    /                  |::|   |            \:::\    /:::/    /              \::::/    /   /:::/    /           
\::/    /                   |::|   |             \:::\__/:::/    /                \::/____/    \::/    /            
 \/____/                    |::|   |              \::::::::/    /                  ~~           \/____/             
                            |::|   |               \::::::/    /                                                    
                            |::|   |                \::::/    /                                                     
                            |::|___|                 \::/____/                                                      
                             ~~                       ~~                                                                                                                                                                           
]]


local display = false
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("tabletopen",function()
    SetDisplay(true)
    TriggerEvent('animations:client:EmoteCommandStart', {"tablet2"})
end)

--very important cb 
RegisterNUICallback("close", function(data)
    SetDisplay(false)
end)

-----------------------------------------------------carjack--------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CreateVehicle", function()
    SetDisplay(false)
    TriggerEvent("utk_fingerprint:Start", 1, 5, 2, function(outcome, reason)
        if outcome == true then -- reason will be nil if outcome is true
            local ModelHash = ("adder") -- Use Compile-time hashes to get the hash of this model
            if not IsModelInCdimage(ModelHash) then return end
            RequestModel(ModelHash) -- Request the model
            while not HasModelLoaded(ModelHash) do -- Waits for the model to load with a check so it does not get stuck in an infinite loop
              Citizen.Wait(10)
            end
            local Vehicle = CreateVehicle(ModelHash, 207.41621, -795.9626, 30.980661, 63.823204, true, false) -- Spawns a networked vehicle on your current coords
            CreateThread(function()
                while true do
                    -- draw every frame
                    Wait(0)
            
                    local pedCoords = GetEntityCoords(PlayerPedId())
                    DrawMarker(2, 207.41621, -795.9626, 30.980661, 63.823204 + 2, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
                end
            end)         
            SetModelAsNoLongerNeeded(ModelHash) -- removes model from game memory as we no longer need it
            exports.pNotify:SetQueueMax("left", 1)

            for i = 0, 1 do
            exports.pNotify:SendNotification({
                text = "A Car was hacked from legion parking model = adder. Go get it NOW!", 
                type = "success", 
                timeout = math.random(1000, 10000),
                layout = "centerLeft",
                queue = "left"
            })
        end	
            print("Succeed")
        elseif outcome == false then
            print("Failed. Reason: "..reason)
        end
    end)       
end)   
--------------------------------------------------------------------------------------------------------------------------------

-- this cb is used as the main route to transfer data back 
-- and also where we hanld the data sent from js
RegisterNUICallback("main", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
    chat(data.error, {255,0,0})
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

function chat(str, color)
    TriggerEvent(
        'chat:addMessage',
        {
            color = color,
            multiline = true,
            args = {str}
        }
    )
end
