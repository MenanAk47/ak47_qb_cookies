resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

name "ak47_qb_cookies"
description "Cookies Shop & Farm"
author "MenanAk47 (MenanAk47#3129)"
version "1.0"

ui_page('html/index.html') 

files({
  'html/index.html',
  'html/script.js',
  'html/style.css',
	'html/img/*.png',
  'html/font/vibes.ttf',
})

client_scripts {
  '@menuv/menuv.lua',
  'config.lua',
  'config-shop.lua',
  'config-farming.lua',
  'config-usable.lua',
  
  'client/utils.lua',
  'client/job.lua',
  'client/shop.lua',
  'client/loader.lua',

  'locales/en.lua',
}

server_scripts {
  'config.lua',
  'config-shop.lua',
  'config-farming.lua',
  'config-usable.lua',

  'server/utils.lua',
  'server/loader.lua',
  'server/shop.lua',
  'server/job.lua',

  'locales/en.lua',
}

dependencies {
  'menuv',
}

