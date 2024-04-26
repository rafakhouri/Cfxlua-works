fx_version "adamant"
game "gta5" 

server_scripts {
   "@vrp/lib/utils.lua",
   "server.lua"
}

client_scripts {
   "@vrp/lib/utils.lua",
   "client.lua"
}

shared_script {'settings/settings.lua'}

files {
   "web/**/*",
}

ui_page "web/index.html"