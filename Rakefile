require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require_relative 'config/application'

desc 'Vérifie le respect des conventions de style du code'
task :rubocop do
  sh 'rubocop --format simple || true'
end

task default: [:rubocop, :spec]

desc 'Ouvre une console Pry avec les modèles et la connexion à la base'
task :console do
  require 'rubygems'
  require 'pry'

  Pry.start
end

# Tâches Rake liées à Active Record
db_namespace = namespace :db do
  desc 'Crée la base de données'
  task :create do
    puts "Creating #{db_path}..."
    touch db_path
  end

  desc 'Supprime la base de données'
  task :drop do
    puts "Deleting #{db_path}..."
    rm_f db_path
  end

  desc 'Exécute les migrations (option : VERSION=x)'
  task :migrate do
    require_relative "./utils"
    FullStackChallengesUtils.rake_migrate(db_namespace, File.dirname(__FILE__))
  end

  desc 'Affiche la version actuelle du schéma'
  task :version do
    puts "Current version: #{ActiveRecord::Base.connection_pool.migration_context.current_version}"
  end

  desc 'Charge les données initiales dans la base'
  task :seed do
    require "#{__dir__}/db/seeds.rb"
  end

  desc 'Affiche un horodatage pour nommer un fichier de migration'
  task :timestamp do
    puts DateTime.now.strftime('%Y%m%d%H%M%S')
  end

  namespace :schema do
     desc 'Génère db/schema.rb à partir de la structure actuelle de la base'
     task :dump do

       require 'active_record/schema_dumper'
       filename = 'db/schema.rb'

       File.open(filename, "w:utf-8") do |file|
         ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection_pool, file)
       end
     end
   end

  private

  def db_path
    ActiveRecord::Base.connection_db_config.database
  end
end
