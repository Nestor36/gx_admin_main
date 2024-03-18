ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback("apx-pmenu:havePermissions", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() == 'socio' then
        cb('socio')
    elseif xPlayer.getGroup() == 'admin' then
        cb('admin')
    elseif xPlayer.getGroup() == 'mod' then
        cb('mod')
    else        
        cb(false)
    end
end)

ESX.RegisterServerCallback('apx-pmenu:getInformation', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    local info = {
        money = xPlayer.getMoney(),
        bankmoney = xPlayer.getAccount('bank').money,
        blackmoney = xPlayer.getAccount('black_money').money,
        nameIs  = xPlayer.getName(),
        myId = source


    }
    cb(info)
end)


lib.callback.register('goto_main_staff', function(source, data)

    local xPlayer = ESX.GetPlayerFromId(source)
    local IdPlayer = data.PlayerId
    Player = ESX.GetPlayerFromId(IdPlayer)
    if not Player then return 'desconectado' end
    local targetCoords =  Player.getCoords()
    
    if data.tp == "goto" then
        xPlayer.setCoords(targetCoords)
    elseif data.tp == "bring" then
        local playerCoords = xPlayer.getCoords()
        
        Player.setCoords(xPlayer.getCoords())
    end

end)


lib.callback.register('identifier_peds', function(source)

    local xPlayer = ESX.GetPlayerFromId(source)
    print(xPlayer.getIdentifier())
    return xPlayer.getIdentifier()

end)


lib.callback.register('add_item_sx', function(source, data) 
    print(json.encode(data))
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(data.item, data.count)

end)


lib.callback.register('get_group', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'socio' then
        cb('socio')
    elseif xPlayer.getGroup() == 'admin' then
        cb('admin')
    elseif xPlayer.getGroup() == 'mod' then
        cb('mod')
    else        
        cb(false)
    end

end)


lib.callback.register('tpm_xd', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.TriggerEvent('esx:tpm')
end)