fx_version 'cerulean'

game "gta5"

author "Byte Labs"
version '1.0.0'
description 'Byte Labs Svelte / CFX Lua template.'
repository 'https://github.com/Byte-Labs-Project/bl_svelte_template'

use_experimental_fxv2_oal 'yes'
lua54 'yes'

-- ui_page 'build/index.html'
ui_page 'http://localhost:3000/' --for dev

client_script {
    'data/config.lua',
    'client/**',
}

files {
    'build/**',
}
