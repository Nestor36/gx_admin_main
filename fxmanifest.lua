--[[
 _____              ______  _      
|  __ \             |  ___|(_)     
| |  \/ _   _ __  __| |_    _  ____
| | __ | | | |\ \/ /|  _|  | ||_  /
| |_\ \| |_| | >  < | |    | | / / 
 \____/ \__,_|/_/\_\\_|    |_|/___|
]]

name 'gux_admin_menu'
author 'Discord: GuxFiz'
description 'gx_admin_menu'

fx_version 'cerulean'
game 'gta5'
version '0.1'

lua54 'yes'


shared_scripts {
	'@ox_lib/init.lua',
	'config.lua'
}

client_scripts {
    'config.lua',
	'client/client.lua',
	'client/lib.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/server.lua'
}

dependencies {
	'oxmysql',
	'ox_lib',
	'ox_inventory'
}

escrow_ignore {
	'config.lua'
}

-- 🐧