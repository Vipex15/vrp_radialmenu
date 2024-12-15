fx_version "cerulean"
lua54 "yes"
games {"gta5"}
lua54 "yes"

ui_page "cfg/html/index.html"

dependency "vrp"

shared_script {
  "@vrp/lib/utils.lua",
  '@ox_lib/init.lua',
}

server_script 'vrp/vrp_s.lua'

client_script 'vrp/c_vrp.lua'

files {
  "cfg/cfg.lua",
  'client/client.lua',
  'cfg/html/index.html',
  'cfg/html/assets/*.js',
  'cfg/html/assets/*.css'
}
