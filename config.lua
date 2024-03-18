Config = {}

Config.notify = 'ox_lib' --  'ox_lib'/'esx'/'custom'?

Config.admins = { -- /setgroup ID mod

    {
        group = "mod",
        permissions = {
            disabled_noclip = false,
            disabled_godmode = false,
            disabled_invisible = false,
            disabled_openveh = true,
            disabled_closeveh = true,
            disabled_fixveh = false,
            disabled_goto = false,
            disabled_bring = false,
            disabled_peds = true,
            disabled_giveitems = false,
            disabled_spawnveh = false,
            disabled_tpMarker = false,
            -- don't add more if you are not a developer
        }
    },

    {
        group = "socio",
        permissions = {
            disabled_noclip = true,
            disabled_godmode = true,
            disabled_invisible = true,
            disabled_openveh = true,
            disabled_closeveh = true,
            disabled_fixveh = true,
            disabled_goto = true,
            disabled_bring = true,
            disabled_peds = true,
            disabled_giveitems = true,
            disabled_spawnveh = true,
            disabled_tpMarker = false,
            -- don't add more if you are not a developer
        }
    },

    {
        group = "director",
        permissions = {
            disabled_noclip = true,
            disabled_godmode = true,
            disabled_invisible = true,
            disabled_openveh = true,
            disabled_closeveh = true,
            disabled_fixveh = true,
            disabled_goto = true,
            disabled_bring = true,
            disabled_peds = true,
            disabled_giveitems = true,
            disabled_spawnveh = true,
            disabled_tpMarker = false,
            -- don't add more if you are not a developer
        }
    },

    {
        group = "admin",
        permissions = {
            disabled_noclip = false,
            disabled_godmode = false,
            disabled_invisible = false,
            disabled_openveh = false,
            disabled_closeveh = false,
            disabled_fixveh = false,
            disabled_goto = false,
            disabled_bring = false,
            disabled_peds = false,
            disabled_giveitems = false,
            disabled_spawnveh = false,
            disabled_tpMarker = false,
            -- don't add more if you are not a developer
        }
    },


}

Config.peds = { 
    {
        identifier = "char1:7ed19d37f770d732e25c17b478705226faac2160",
        peds = {
            {ped = "evo01"},
            {ped = "eva01"},
            {ped = "asddd"},
            {ped = "asdd"},
        }
    },
}


Config.items = {

    {
        group = "mod",
        items = {
            {item = "water", amount = 1},
            {item = "burger", amount = 1},
            {item = "skateboard", amount = 1},
        }
    },
    {
        group = "socio",
        items = {
            {item = "asdasd", amount = 1},
            {item = "asdasd", amount = 1},
        }
    },
    {
        group = "admin",
        items = {
            {item = "water",  amount = 1},
            {item = "burger", amount = 1},  
        }
    },
    
}

Config.vehicles = {
    --[[
    {
        group = "mod",  -- admin/socio/mod/etc..
        cars = {
            {car = "taxi"},
            {car = "taxi"},
            {car = "taxi"}, -- can u add more...
            {car = "taxi"},
            {car = "taxi"},
            {car = "taxi"},
        }
    },
]]
    {
        group = "mod",
        cars = {
            {car = "sanchez"},
            {car = "blista"},
        }
    },
    {
        group = "admin",
        cars = {
            {car = "blista"},
            {car = "zentorno"},
            {car = "t20"},
        }
    },
}


Config.gps = {

    {
        title = 'Garaje', -- Tittle
        icon = 'location-dot',    -- Icon
        onSelect = function()
            SetNewWaypoint(215.12, -815.74) -- coords of Marker In Map
        end,
    },
    {
        title = 'Garaje',
        icon = 'location-dot',
        onSelect = function()
            SetNewWaypoint(215.12, -815.74)
        end,
    },    
   -- can u more..

}


Config.translate = {
--  ES
---  Notify
    ['server_name'] = 'server_name',
    ['graphics_in'] = 'Gráficos Activados',
    ['graphics_off'] = 'Gráficos Desactivados',
    ['voice_reset'] = 'Reiniciaste el chat de Voz',
    ['godmode_in'] = 'GodMode Activado',
    ['godmode_off'] = 'GodMode Desactivado',
    ['invi_in'] = 'Invisible Activado',
    ['invi_off'] = 'Invisible Desactivado',
    ['no_veh'] = 'No estás cerca de un Vehículo',
    ['open_veh'] = 'Vehículo Desbloqueado',
    ['close_veh'] = 'Vehículo Asegurado',
    ['no_fix_veh'] = 'Debes estar dentro de un vehículo',
    ['fix_veh'] = 'Arreglaste el vehículo',
    ['goto'] = 'Te teletransportaste con éxito!',
    ['bring'] = 'Trajiste al Jugador con éxito!',
    ['no_ped'] = 'El Ped no fue encontrado o no existe!',
    ['no_identifier_ped'] = 'No estás en la lista asignada de Peds!',
    ['noclip_in'] = 'Activaste Noclip',
    ['noclip_off'] = 'Desactivaste Noclip',
    ['waypoint_off'] = 'Marca algún lugar en el mapa!',
    ['waypoint_on'] = 'Teletransportado al Punto seleccionado',
    ['asd'] = 'server_name',
    ['zz'] = 'server_name',
    ['sad'] = 'server_name',
    ['asd'] = 'server_name',

}
