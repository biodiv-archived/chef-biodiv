include_recipe "postgresql::server"
include_recipe "database::postgresql"

postgresql_connection_info = {:host => "localhost",
                              :port => node['postgresql']['config']['port'],
                              :username => 'postgres',
                              :password => node['postgresql']['password']['postgres']}


# create a postgresql database
postgresql_database node.geoserver.database do
  connection postgresql_connection_info
  action :create
end


# create a postgresql user but grant no privileges
postgresql_database_user node['geoserver']['database-user'] do
  connection postgresql_connection_info
  password node['geoserver']['database-password']
  action :create
end

# grant all privileges on all tables in foo db
postgresql_database_user node['geoserver']['database-user'] do
  connection postgresql_connection_info
  database_name node.geoserver.database
  privileges [:all]
  action :grant
end

