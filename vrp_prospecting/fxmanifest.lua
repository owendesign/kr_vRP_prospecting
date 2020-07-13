fx_version "adamant"
game "gta5"

description "Prospecting plugin for ESX"

dependencies {"prospecting"}

server_scripts {
"@prospecting/interface.lua",
"@vrp/lib/utils.lua",
"hi_server.lua",
"config.lua"
}

client_scripts {
 "hi_client.lua",
 "config.lua"
 }

