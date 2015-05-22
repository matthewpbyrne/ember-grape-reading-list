if ENV['RACK_ENV'] == 'test'  
  db_config = YAML.load_file('config/database.yml')
  db_name   = db_config['test']['database']
  DB        = Sequel.connect("sqlite://#{db_name}")  
end