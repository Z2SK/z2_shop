TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Z2LTD:buy')
AddEventHandler('Z2LTD:buy', function(item, price)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    if xPlayer.getAccount("cash").money >= price then
        xPlayer.removeAccountMoney("cash", price)
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('::{korioz#0110}::esx:showNotification', src, 'Vous avez acheter ~r~1 ~g~' .. item)
    else
        TriggerClientEvent('::{korioz#0110}::esx:showNotification', src, '~r~Vous n\'avez pas assez d\'argent malhreusement :\'(')
    end
end)