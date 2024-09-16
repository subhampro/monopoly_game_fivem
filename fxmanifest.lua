fx_version 'cerulean'
games { 'gta5' }

author 'SubhamPRO'
description 'Monopoly Game for FiveM'
version '1.0.0'

server_scripts {
    'server/config.lua',
    'server/server.lua'   
}

client_scripts {
    'client/ui.lua', 
    'client/client.lua',
    'client/dice.lua',  
}

files {
    'html/ui.html',
    'html/style.css',
    'html/script.js'
}

ui_page 'html/ui.html'
