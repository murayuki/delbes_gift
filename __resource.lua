resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'delbes_gift'


server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'delbes_gift-sv.lua'
}

client_scripts {
	'delbes_gift-cl.lua'
}