include_attribute "tomcat"

expand!

default[:geoserver][:version]   = "2.5.2"
default[:geoserver][:directory] = "/usr/local/src"
default[:geoserver][:checksum]  = "1b4552ba95c8456d4fbd596e82028eaa0619b6942786e98e1c4c31258543c708" #sha265

default[:geoserver][:link]      = "http://sourceforge.net/projects/geoserver/files/GeoServer/#{geoserver.version}/geoserver-#{geoserver.version}-war.zip"
default[:geoserver][:extracted] = "#{geoserver.directory}/geoserver-#{geoserver.version}"
default[:geoserver][:war]       = "#{geoserver.extracted}/geoserver.war"
default[:geoserver][:download]  = "#{geoserver.directory}/geoserver-#{geoserver.version}.zip"

default[:geoserver][:home]          = "/var/local/geoserver-#{geoserver.version}"
default[:geoserver][:context_path]  = 'geoserver'
default[:geoserver][:data]          = "/var/local/geoserver-#{geoserver.version}/data"
