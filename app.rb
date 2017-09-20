require ('sinatra')
require ('sinatra/reloader')
also_reload('lib/**/*.rb')
require ('./lib/doctor')
require ('pry')

DB = PG.connect({:dbname => "admin_database"})

get('/') do
erb(:input)
end

post('/patientForm') do
  @name = params.fetch('name')
  @dob = params.fetch('dob')
  

erb(:input)
end
