fx_version 'adamant'

version '1.0.0'

game 'gta5'
description 'Jail script by fryr'

client_script 'client.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

files {
    --'jail_data.json'
}

shared_script {
    '@qb-core/shared/locale.lua',
}