fx_version 'adamant'

game 'gta5'

description 'capy_switch'
lua54 'yes'
version '0.1'


shared_script {
	'@es_extended/imports.lua',
	'config.lua'}

server_scripts {
	'server/*.lua',
}

client_scripts {
	'client/*.lua',
}

dependency 'es_extended'
