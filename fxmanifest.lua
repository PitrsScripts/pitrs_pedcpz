fx_version 'cerulean'
game 'gta5'

author 'Pitrs'
description 'NPC Interaction police cpz'
version '1.0'

lua54 'yes'

dependencies {
    'ox_lib',
    'ox_target',
    'ox_inventory'
}

client_scripts {
    '@ox_lib/init.lua', 
    'client.lua'
}

server_script 'server.lua' 

shared_script 'config.lua'
