require ('sinatra')
require ('sinatra/reloader')
also_reload('lib/**/*.rb')
require ('./lib/doctor')
require ('pry')

DB = PG.connect({:dbname => "admin_database"})
