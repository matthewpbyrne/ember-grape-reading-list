if (ENV['RACK_ENV'] == 'development') || ENV['RACK_ENV'].nil?
  db_config = YAML.load_file('config/database.yml')
  db_name   = db_config['development']['database']
  DB        = Sequel.connect("sqlite://#{db_name}")  
end