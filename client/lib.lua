function Notify(msg)

    if Config.notify == 'ox_lib' then
        lib.notify({
            title = Config.translate['server_name'],
            description = msg,
            type = 'inform',
            position = 'top',
        })
    elseif Confi.notify == 'esx' then
        ESX.ShowNotification(msg)
    else -- custom
        print(msg)
    end

end
