ESX = exports["es_extended"]:getSharedObject()

apx_noclip = false

--RegisterKeyMapping('MenuPersonal', 'Abre el menu personal.', 'keyboard', 'F5')

--[[
RegisterCommand('MenuPersonal', function()
    PersonalMenu(source)
end)
]]

RegisterCommand('lzs', function()
    MainPersonal()
end)

MainPersonal = function()

    lib.registerContext({
        id = 'gx_main_personal',
        title = 'Menu Personal',
        options = {
          {
            title = 'Información',
            description = 'Información Personal',
            menu = 'info_personal',
            icon = 'user',
          },
          {
            title = 'Otros',
            description = 'Podras Arreglar bugs y más!',
            menu = 'info_anothers',
            icon = 'bars'
          },
          {
            title = 'Socio',
            description = 'Solo podrás acceder aquí sí eres socio!',
            icon = 'check',
            event = 'soy_socio_a',
            
          }
        }
      })

    ESX.TriggerServerCallback('apx-pmenu:getInformation', function(info)
        local name = GetPlayerName(PlayerId())
        local Data = ESX.GetPlayerData()
        local job = Data.job.label
        local jobgrade = Data.job.grade_label
        local money = info.money
        local bank = info.bankmoney
        local blackmoney = info.blackmoney
        local nameIs = info.nameIs
        local myId = info.myId
        
        

      lib.registerContext({
        id = 'info_personal',
        title = 'Información Personal',
        menu = 'gx_main_personal',
        onBack = function()
            --lib.showContext('gx_main_personal')
          --print('Went back!')
        end,
        options = {
          {
            title = 'Nombre: '..nameIs..' ['..myId..']',
            description = 'User: '..name,
            icon = 'user'
          },
          {
            title = 'Trabajo: '..job..' - '..jobgrade,
            icon = 'briefcase'
          },
          {
            title = 'Bank : $'..bank,
            icon = 'wallet'
          },
          {
            title = 'Cash: $'..money,
            icon = 'money-bill-wave'

          },
          {
            title = 'Dinero Sucio: $'..blackmoney,
            icon = 'sack-xmark'
          }
        }
      })

    end)

      lib.registerContext({
        id = 'info_anothers',
        title = 'Otras opciones',
        menu = 'gx_main_personal',
        options = {
            {
                title = 'Activar/Desactivar Gráficos',
                icon = 'wand-magic-sparkles',
                onSelect = function()
                    if not graf then
                        graf = true
                        SetTimecycleModifier('MP_Powerplay_blend')
                        SetExtraTimecycleModifier('reflection_correct_ambient')
                        Notify(Config.translate['graphics_in'])
                    else 
                        graf = false
                        ClearTimecycleModifier()
                        ClearExtraTimecycleModifier()
                        Notify(Config.translate['graphics_off'])
                    end
                end
              },
              {
                title = 'Resetear Voz',
                icon = 'microphone',
                onSelect = function()
                    NetworkClearVoiceChannel()
                    NetworkSessionVoiceLeave()
                    Wait(50)
                    NetworkSetVoiceActive(false)
                    MumbleClearVoiceTarget(2)
                    Wait(1000)
                    MumbleSetVoiceTarget(2)
                    NetworkSetVoiceActive(true)
                    Notify(Config.translate['voice_reset'])
                end
              },
              {
                title = 'Resetear PJ',
                icon = 'person',
                onSelect = function()
                    ExecuteCommand('reloadskin')
                end,
              },
              {
                title = 'GPS Rápido',
                icon = 'globe',
                menu = 'info_gps',
    
              },
        }
      })

      lib.registerContext({
        id = 'info_gps',
        title = 'GPS Rápido',
        menu = 'info_anothers',
        options = Config.gps
      })

      lib.showContext('gx_main_personal')


end


RegisterNetEvent('soy_socio_a')
AddEventHandler('soy_socio_a', function() 

    print('soy socio? :v')

    ESX.TriggerServerCallback('apx-pmenu:havePermissions', function(cb)

        local MyPermissions = {}
        for i = 1, #Config.admins do

            print("soy => ", cb)
            print("a => ", Config.admins[i])
            local group = Config.admins[i].group
            print(group, cb)
            if group == cb then
                print("dx", cb)
                --for e = 1, #Config.admins[i].permissions do
                    
                    local permissions = Config.admins[i].permissions

                    print("z => ", json.encode(Config.admins[i].permissions))

                    print("dx => ", json.encode(permissions.disabled_noclip))
                    TriggerEvent('gx_main_staff', cb, permissions)
                    print("tmre => ", json.encode(permissions.disabled_godmode))
                    --table.insert(MyPermissions, permissions)
                --end


            end



        end
        print("pz => ", json.encode(MyPermissions))
        --TriggerEvent('gx_main_staff', cb)
        --[[
        if cb == 'admin' then
            TriggerEvent('gx_main_staff', cb, {noclip = false, godmode = false})
        elseif cb == 'mod' then
            TriggerEvent('gx_main_staff', cb)
        elseif cb == 'socio' then
            TriggerEvent('gx_main_staff', cb)
            
        else

            print('no soi')

        end
        ]]
        print("soy => ", cb)
    end)

end)

RegisterNetEvent('gx_main_staff')
AddEventHandler('gx_main_staff', function(cb, data)
    
    print(cb, data.noclip)

    lib.registerContext({
        id = 'admin_staff',
        title = 'Menú de '..cb,
        menu = 'gx_main_personal',
        options = {
            {
                title = 'Noclip',
                icon = 'glasses',
                disabled = data.disabled_noclip,
                onSelect = function()
                    TriggerEvent('apx_noclip')
                end
            },
              {
                title = 'GodMode',
                icon = 'shield',
                disabled = data.disabled_godmode,
                onSelect = function()
                    if godmode then
                        SetEntityInvincible(PlayerPedId(), true)
                        Notify(Config.translate['godmode_in'])
                        godmode = false
                    else
                        SetEntityInvincible(PlayerPedId(), false)
                        Notify(Config.translate['godmode_off'])
                        godmode = true
                    end
                end
              },
              {
                title = 'invisible',
                icon = 'eye-slash',
                disabled = data.disabled_invisible,
                onSelect = function()
                    if invisible then
                        SetEntityVisible(PlayerPedId(), false)
                        Notify(Config.translate['invi_in'])
                        invisible = false
                    else
                        SetEntityVisible(PlayerPedId(), true)
                        Notify(Config.translate['invi_off'])
                        invisible = true
                    end
                end,
              },
              {
                title = 'Abrir Vehículo',
                icon = 'lock-open',
                disabled = data.disabled_openveh,
                onSelect = function()
                    local coords = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 8.0, 0, 71)
                    if coords < 1 then
                        Notify(Config.translate['no_veh'])
                    else
                        SetVehicleDoorsLocked(coords, 1)
                        Notify(Config.translate['open_veh'])
                    end
                end,
              },
              {
                title = 'Cerrar Vehículo',
                icon = 'lock',
                disabled = data.disabled_closeveh,
                onSelect = function()
                    local coords = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 8.0, 0, 71)
                    if coords < 1 then
                        Notify(Config.translate['no_veh'])
                    else
                        SetVehicleDoorsLocked(coords, 2)
                        Notify(Config.translate['close_veh'])
                    end
                end,
              },
              {
                title = 'Arreglar Vehículo',
                icon = 'screwdriver-wrench',
                disabled = data.disabled_fixveh,
                onSelect = function()
                    if IsPedInAnyVehicle(PlayerPedId()) then 
                        SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId()))
                        SetVehicleDeformationFixed(GetVehiclePedIsIn(PlayerPedId()))
                        SetVehicleUndriveable(GetVehiclePedIsIn(PlayerPedId()), false)
                        SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()), true, true)
                        Notify(Config.translate['fix_veh'])
                    else
                        Notify(Config.translate['no_fix_veh'])
                    end
                end,
              },
              {
                title = 'Ir al Jugador',
                icon = 'user-group',
                disabled = data.disabled_goto,
                onSelect = function()
                    local input = lib.inputDialog('Ir al Jugador', {'ID Player'})
                    if not input then return end
                    local uID = tonumber(input[1])
                    lib.callback('goto_main_staff', source, function(result)
                        if result == 'desconectado' then
                            lib.alertDialog({
                                header = "Menú de staff",
                                content = 'El jugador está desconectado',
                                centered = true,
                                size = 'sm',
                                labels = {confirm = 'confirmar'}
                            })
                        else
                            Notify(Config.translate['goto'])
                        end
                    end, {PlayerId = uID, tp = "goto"})
                end,
              },
              {
                title = 'Traer al Jugador',
                icon = 'person-circle-plus',
                disabled = data.disabled_bring,
                onSelect = function()
                    local input = lib.inputDialog('Traer al Jugador', {'ID Player'})
                    if not input then return end
                    local uID = tonumber(input[1])
                    lib.callback('goto_main_staff', source, function(result)
                        if result == 'desconectado' then
                            lib.alertDialog({
                                header = "Menú de staff",
                                content = 'El jugador está desconectado',
                                centered = true,
                                size = 'sm',
                                labels = {confirm = 'confirmar'}
                            })
                        else
                            Notify(Config.translate['bring'])
                        end
                    end, {PlayerId = uID, tp = "bring"})
                end,
              },
            {
                title = 'Gestión de Peds',
                icon = 'list-check',
                disabled = data.disabled_peds,
                onSelect = function()

                    local result = lib.callback('identifier_peds', source, false)
                    listPed = {}
                    for i = 1, #Config.peds do
                        print("a => ", Config.peds[i])
                        local ped_identifier = Config.peds[i].identifier
                        print("b => ", ped_identifier)
                        print('Z => ', result)

                        if ped_identifier == result then
                            print("????")

                            for e = 1, #Config.peds[i].peds do
                                print("z => ", Config.peds[i].peds[e])

                                local PedList = {
                                    title = Config.peds[i].peds[e].ped,
                                    icon = 'car',
                                    onSelect = function()
                                        local ped_models = Config.peds[i].peds[e].ped
                                        print("seleccionado : ".. Config.peds[i].peds[e].ped)

                                        if not type(ped_models) == "number" then ped_models = 'pedModel' end
                                        if IsModelInCdimage(ped_models) then
                                            while not HasModelLoaded(ped_models) do
                                                Citizen.Wait(15)
                                                RequestModel(ped_models)
                                            end
                                            SetPlayerModel(PlayerId(), ped_models)
                                        else
                                            Notify(Config.translate['no_ped'])
                                        end
                
                                    end
                                }
                                
                                table.insert(listPed, PedList)
                
                            end
                
                        else
                
                            Notify(Config.translate['no_identifier_ped'])
                        
                        end
                
                    end
                

                    lib.registerContext({
                        id = 'menu_ped_main',
                        title = 'Menu de Peds',
                        options = listPed
                    })
                    lib.showContext('menu_ped_main')


                end
            },
            {
                title = 'Obtener Items',
                icon = 'list-check',
                disabled = data.disabled_giveitems,
                onSelect = function()

                    local result = lib.callback('identifier_peds', source, false)
                    listItems = {}

                    --local getgroup = lib.callback('get_group', source, false)
                    
                    for i = 1, #Config.items do
                    
                        print("a => ", Config.items[i])
                        local ped_identifier = Config.items[i].group
                        print("b => ", ped_identifier)
                        print('Z => ', result)

                        if ped_identifier == cb then
                            print("????")

                            for e = 1, #Config.items[i].items do
                                print("z => ", Config.items[i].items[e])

                                local ItemList = {
                                    title = Config.items[i].items[e].item,
                                    icon = 'car',
                                    onSelect = function()
                                        --local ped_models = Config.items[i].peds[e].ped
                                        local item_select = Config.items[i].items[e].item
                                        local item_amount = Config.items[i].items[e].amount
                                        print("seleccionado : ".. Config.items[i].items[e].item)

                                        lib.callback('add_item_sx', source, false, {item = item_select, count = item_amount})                
                                    end
                                }
                                
                                table.insert(listItems, ItemList)
                
                            end
                        else
                            print('identifier no coincide')
                        end
                    end

                    lib.registerContext({
                        id = 'main_items_gx',
                        title = 'Menu de items',
                        options = listItems
                    })
                    lib.showContext('main_items_gx')

                end
            },
            {
                title = 'Spawn Coches',
                icon = 'list',
                disabled = data.disabled_spawnveh,
                onSelect = function()
                    
                    listCar = {}

                    for i = 1, #Config.vehicles do
                        print("a => ", Config.vehicles[i])
                        local group = Config.vehicles[i].group
                        print("b => ", group, cb)
                        --print('Z => ', cb)

                        if group == cb then
                            print("????")

                            for e = 1, #Config.vehicles[i].cars do
                                print("z => ", Config.vehicles[i].cars[e])

                                local PedList = {
                                    title = Config.vehicles[i].cars[e].car,
                                    icon = 'car',
                                    onSelect = function()
                                        local mycar = Config.vehicles[i].cars[e].car
                                        local ped = PlayerPedId()
                                        print(GetEntityCoords(ped), mycar)
                                        local bmxBikeModel = mycar
                                        RequestModel(bmxBikeModel)
                                        while not HasModelLoaded(bmxBikeModel) do
                                            Wait(0)
                                        end

                                        local carcreate = CreateVehicle(bmxBikeModel, GetEntityCoords(ped) + 1.0, GetEntityHeading(PlayerPedId()), true, false)
                                        SetPedIntoVehicle(PlayerPedId(), carcreate, -1)

                                        --GetPedInVehicleSeat(carcreate, -1)

                                        --[[
                                        lib.callback('spawn_vehicle', source, function(result)
                                        
                                        
                                        end, {coords = GetEntityCoords(ped), car = mycar})
]]
                                    end
                                }
                                
                                table.insert(listCar, PedList)
                
                            end
                
                        else
                
                            print('group no identificado O.o')
                        
                        end
                
                    end

                    lib.registerContext({
                        id = 'main_cars_gx',
                        title = 'Menu de cars',
                        options = listCar
                    })
                    lib.showContext('main_cars_gx')
                
                end
            },
            {
                title = 'TP Marker',
                icon = 'location-dot',
                disabled = data.disabled_tpMarker,
                onSelect = function()

                    local waypointHandle = GetFirstBlipInfoId( 8 )

                    if DoesBlipExist( waypointHandle ) then
                        local blipCoords = GetBlipInfoIdCoord( waypointHandle )
                 incr=0
                 DoScreenFadeOut(100)
                 CreateThread(function()
                    while incr<1000 do
                        Wait(1) 
                        incr=incr+1
                            
                            SetEntityCoords( GetPlayerPed( -1 ), blipCoords.x, blipCoords.y, incr*1.0, 0.0, 0.0, 0.0, false )
                            
                            foundGround,g = GetGroundZFor_3dCoord(blipCoords.x, blipCoords.y, incr*1.0)
                            
                            if foundGround then
                                print(g)
                                SetEntityCoords( GetPlayerPed( -1 ), blipCoords.x, blipCoords.y,g*1.0, 0.0, 0.0, 0.0, false )
                                DoScreenFadeIn(500)
                                Notify(Config.translate['waypoint_on'])
                                break
                            end
                            
                        end
                    end)
                    if incr>900 then
                        DoScreenFadeIn(500)
                        --just in case
                    end
                      --  print( blipCoords )
                       -- TriggerEvent( "aq:getCoords" )
                    else
                     Notify(Config.translate['waypoint_off'])
                        --TriggerEvent( "aq:notify", "~y~Place a waypoint." )
                    end
                
                end
            },
            
        }
    })

    lib.showContext('admin_staff')

end)



-- PLUS FUNCTION --

CreateThread(function()
    while true do 
        local apx = 1000
        if apx_noclip then
            apx = 0
            local x,y,z = Posicion()
            local dx,dy,dz = Direccion()
            local speed = 2.0

            SetEntityVelocity(PlayerPedId(), 0.05,  0.05,  0.05)

            if IsControlPressed(0, 32) then
                apx = 0
                x = x + speed * dx
                y = y + speed * dy
                z = z + speed * dz
            end

            if IsControlPressed(0, 269) then
                apx = 0
                x = x - speed * dx
                y = y - speed * dy
                z = z - speed * dz
            end

            SetEntityCoordsNoOffset(PlayerPedId(),x,y,z,true,true,true)
        end
        Citizen.Wait(apx)
    end
end)

-- EVENTS --

RegisterNetEvent('apx_noclip')
AddEventHandler('apx_noclip',function()
	apx_noclip = not apx_noclip

    if apx_noclip then
    	SetEntityInvincible(PlayerPedId(), true)
    	SetEntityVisible(PlayerPedId(), false, false)
    else
    	SetEntityInvincible(PlayerPedId(), false)
    	SetEntityVisible(PlayerPedId(), true, false)
    end

    if apx_noclip == true then 
        Notify(Config.translate['noclip_in'])
    else
        Notify(Config.translate['noclip_off'])
    end
end)



-- COMMANDS --
--[[
RegisterCommand('rvoz', function()
    NetworkClearVoiceChannel()
    NetworkSessionVoiceLeave()
    Wait(50)
    NetworkSetVoiceActive(false)
    MumbleClearVoiceTarget(2)
    Wait(1000)
    MumbleSetVoiceTarget(2)
    NetworkSetVoiceActive(true)
    Notify('~g~Chat de voz reiniciado.')
  end)

RegisterCommand('fixpj', function()
    local hp = GetEntityHealth(PlayerPedId())
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local isMale = skin.sex == 0
        TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                TriggerEvent('esx:restoreLoadout')
                TriggerEvent('dpc:ApplyClothing')
                SetEntityHealth(PlayerPedId(), hp)
            end)
        end)
    end)
end, false)
]]
-- FUNCTIONS --

TxT = function(text)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(6)
	SetTextScale(0.4, 0.4)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.85, 0.020)
end

FormatCoord = function(coord)
	if coord == nil then
		return "unknown"
	end

	return tonumber(string.format("%.2f", coord))
end

Posicion = function()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
  	return x,y,z
end

Direccion = function()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
	local pitch = GetGameplayCamRelativePitch()
  
	local x = -math.sin(heading*math.pi/180.0)
	local y = math.cos(heading*math.pi/180.0)
	local z = math.sin(pitch*math.pi/180.0)
  
	local len = math.sqrt(x*x+y*y+z*z)
	if len ~= 0 then
	  x = x/len
	  y = y/len
	  z = z/len
	end
  
	return x,y,z
end

GPS = function()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gps',{
        title = 'GPS Rápido',
		    align = Config.Align,
		    elements = {
			  {label = 'Garage Cental', value = 'garaje'},
			  {label = 'Comisaria', value = 'comisaria'}, 
			  {label = 'Hospital', value = 'hospital'}, 
			  {label = 'Concesionario', value = 'conce'},
			  {label = 'Mecánico', value = 'mecanico'},
			  {label = 'Badulake Central', value = 'badu'},	
		 }
  },
	function(data, menu)
		local fastgps = data.current.value
		
		if fastgps == 'garaje' then
			SetNewWaypoint(215.12, -815.74)
            ESX.UI.Menu.CloseAll()
		elseif fastgps == 'comisaria' then 
			SetNewWaypoint(411.28, -978.73)
            ESX.UI.Menu.CloseAll()
		elseif fastgps == 'hospital' then 
			SetNewWaypoint(291.37, -581.63)
            ESX.UI.Menu.CloseAll()
        elseif fastgps == 'conce' then
			SetNewWaypoint(-33.78, -1102.12)
            ESX.UI.Menu.CloseAll()
		elseif fastgps == 'mecanico' then
			SetNewWaypoint(-359.59, -133.44)
            ESX.UI.Menu.CloseAll()
		elseif fastgps == 'badu' then
			SetNewWaypoint(-708.01, -913.8)
            ESX.UI.Menu.CloseAll()
		end
	end,
	function(data, menu)
		menu.close()
	end)
end

CambiarAsiento = function()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'asientos', {
		title = 'Selección de asientos',
		align = Config.Align,
		elements = {
            {label = 'Asiento 1', value = 'asiento1'},
            {label = 'Asiento 2', value = 'asiento2'},
            {label = 'Asiento 3', value = 'asiento3'},
            {label = 'Asiento 4', value = 'asiento4'},   
        }}, function(data, menu)
        local asientos = data.current.value 
		if asientos == 'asiento1' then 
			SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), -1)
		elseif asientos == 'asiento2' then
			SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 0)
		elseif asientos == 'asiento3' then 
			SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 1)
		elseif asientos == 'asiento4' then 
			SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 2)
		end
	end, function(data, menu)
		menu.close()
	end)
end

Ventanas = function()
    local izquierdafrontal = true
    local derechafrontal = true
    local izquierdaatras = true
    local derechaatras = true
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apx_ventanas', {
			title    = 'Ventanas',
			align    = Config.Align,
			elements = {
                {label = 'Ventanilla delantera izquierda', value = 'izquierdafrontal'},
                {label = 'Ventanilla delantera derecha', value = 'derechafrontal'},
                {label = 'Ventanilla trasera izquierda', value = 'izquierdaatras'},
                {label = 'Ventanilla trasera derecha', value = 'derechaatras'},
                {label = 'Bajar todas las ventanillas', value = 'bajartodas'},
                {label = 'Subir todas las ventanillas', value = 'subirtodas'}
            }}, function(data, menu)
                local vent = data.current.value 
			if vent == 'izquierdafrontal' then
				if not izquierdafrontal then
					izquierdafrontal = true
					RollUpWindow(GetVehiclePedIsIn(PlayerPedId(),false), 0, false)
				elseif izquierdafrontal then
					izquierdafrontal = false
					RollDownWindow(GetVehiclePedIsIn(PlayerPedId(),false), 0, false)
				end
			elseif vent == 'derechafrontal' then
				if not derechafrontal then
					derechafrontal = true
					RollUpWindow(GetVehiclePedIsIn(PlayerPedId(),false), 1, false)
				elseif derechafrontal then
					derechafrontal = false
					RollDownWindow(GetVehiclePedIsIn(PlayerPedId(),false), 1, false)
				end
			elseif vent == 'izquierdaatras' then
				if not izquierdaatras then
					izquierdaatras = true
					RollUpWindow(GetVehiclePedIsIn(PlayerPedId(),false), 2, false)
				elseif izquierdaatras then
					izquierdaatras = false
					RollDownWindow(GetVehiclePedIsIn(PlayerPedId(),false), 2, false)
				end
			elseif vent == 'derechaatras' then
				if not derechaatras then
					derechaatras = true
					RollUpWindow(GetVehiclePedIsIn(PlayerPedId(),false), 3, false)
				elseif derechaatras then
					derechaatras = false
					RollDownWindow(GetVehiclePedIsIn(PlayerPedId(),false), 3, false)
				end
			elseif vent == 'bajartodas' then
				izquierdafrontal = true
				derechafrontal = true
				izquierdaatras = true
				derechaatras = true
				RollDownWindows(GetVehiclePedIsIn(PlayerPedId(), false))
			elseif vent == 'subirtodas' then
				izquierdafrontal = false
				derechafrontal = false
				izquierdaatras = false
				derechaatras = false
				RollUpWindow(GetVehiclePedIsIn(PlayerPedId(),false), 0, false)
				RollUpWindow(GetVehiclePedIsIn(PlayerPedId(),false), 1, false)
				RollUpWindow(GetVehiclePedIsIn(PlayerPedId(),false), 2, false)
				RollUpWindow(GetVehiclePedIsIn(PlayerPedId(),false), 3, false)
			end
		end, function(data, menu)
            menu.close()
	end)
end

local izquierdafrontal = false
local derechafrontal = false
local izquierdaatras = false
local backrightdoors = false
Puertas = function()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_controls_doors', {
			title    = 'Puertas',
			align    = Config.Align,
			elements = {
                {label = 'Puerta delantera izquierda', value = 'izquierdafrontal'},
                {label = 'Puerta delantera derecha', value = 'derechafrontal'},
                {label = 'Puerta trasera izquierda', value = 'izquierdaatras'},
                {label = 'Puerta trasera derecha', value = 'derechaatras'},
                {label = 'Abrir todas las puertas', value = 'abrirtodas'},
                {label = 'Cerrar todas las puertas', value = 'cerrartodas'}
            }}, function(data, menu)
                local puert = data.current.value
			if puert == 'izquierdafrontal' then
				if not izquierdafrontal then
					izquierdafrontal = true
					SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 0, false)
				elseif izquierdafrontal then
					izquierdafrontal = false
					SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(),false), 0, false)
				end
			elseif puert == 'derechafrontal' then
				if not derechafrontal then
					derechafrontal = true
					SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 1, false)
				elseif derechafrontal then
					derechafrontal = false
					SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(),false), 1, false)
				end
			elseif puert == 'izquierdaatras' then
				if not izquierdaatras then
					izquierdaatras = true
					SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 2, false)
				elseif izquierdaatras then
					izquierdaatras = false
					SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(),false), 2, false)
				end
			elseif puert== 'derechaatras' then
				if not derechaatras then
					derechaatras = true
					SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 3, false)
				elseif derechaatras then
					derechaatras = false
					SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(),false), 3, false)
				end
			elseif puert == 'abrirtodas' then
				izquierdafrontal = true
				derechafrontal = true
				izquierdaatras = true
				derechaatras = true
				SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 0, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 1, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 2, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 3, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 4, false)
				SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(),false), 5, false)
			elseif puert == 'cerrartodas' then
				izquierdafrontal = false
				derechafrontal = false
				izquierdaatras = false
				derechaatras = false
				SetVehicleDoorsShut(GetVehiclePedIsIn(PlayerPedId(),false))															
			end
		end, function(data, menu)
            menu.close()
	end)
end
