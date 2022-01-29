local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("darktablet", function(source)
   TriggerClientEvent('tabletopen',source)
end)