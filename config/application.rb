require 'bundler/setup'

require 'active_record'
require 'sqlite3'
require 'yaml'
require 'logger'

# Lit la configuration dans config/database.yml pour préparer la connexion à la base.
config_path = File.join(File.dirname(__FILE__), "database.yml")
ActiveRecord::Base.configurations = YAML.load_file(config_path)
# APP_ENV=test permet de travailler dans une base séparée pour les tests.
environment = ENV.fetch('APP_ENV', 'development')
database_config = ActiveRecord::Base.configurations.configs_for(env_name: environment, name: 'primary')
raise "Environnement inconnu : #{environment}" unless database_config

ActiveRecord::Base.establish_connection(
  database_config.configuration_hash.merge(database: File.expand_path(database_config.database, File.join(__dir__, '..')))
)

# Affiche les requêtes SQL exécutées par Active Record dans la console.
logger = Logger.new($stdout)
logger.formatter = proc do |_severity, _datetime, _progname, msg|
  "#{msg}\n"
end
ActiveRecord::Base.logger = logger

# Charge tous les modèles du projet.
def reload!
  # Appeler reload! dans la console pour recharger les modèles après une modification.
  Dir["#{__dir__}/../app/models/*.rb"].each { |file| load file }
end

reload!
