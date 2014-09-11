include_attribute "tomcat"

expand!

default[:solr][:version]   = "4.10.0"
default[:solr][:directory] = "/usr/local/src"
default[:solr][:checksum]  = "1b4552ba95c8456d4fbd596e82028eaa0619b6942786e98e1c4c31258543c708" #sha265

if solr.version.split('.').first.to_i >= 4
  default[:solr][:link]      = "http://www.mirrorservice.org/sites/ftp.apache.org/lucene/solr/#{solr.version}/solr-#{solr.version}.tgz"
  default[:solr][:download]  = "#{solr.directory}/solr-#{solr.version}.tgz"
  default[:solr][:extracted] = "#{solr.directory}/solr-#{solr.version}"
  default[:solr][:war]       = "#{solr.extracted}/dist/solr-#{solr.version}.war"
else
  default[:solr][:link]      = "http://www.mirrorservice.org/sites/ftp.apache.org/lucene/solr/#{solr.version}/apache-solr-#{solr.version}.tgz"
  default[:solr][:download]  = "#{solr.directory}/apache-solr-#{solr.version}.tgz"
  default[:solr][:extracted] = "#{solr.directory}/apache-solr-#{solr.version}"
  default[:solr][:war]       = "#{solr.extracted}/dist/apache-solr-#{solr.version}.war"
end

default[:solr][:home]          = "/var/local/solr-#{solr.version}"
default[:solr][:context_path]  = 'solr'
default[:solr][:data]          = "/var/local/solr-#{solr.version}/data"
default[:solr][:custom_config] = nil
default[:solr][:custom_lib]    = nil
