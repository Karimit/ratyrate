require 'rails/generators/migration'
require 'rails/generators/active_record'
class RatyrateGenerator < ActiveRecord::Generators::Base
  include Rails::Generators::Migration

  source_root File.expand_path('../templates', __FILE__)

  desc "model is creating..."
  def create_model
    model_file = File.join('app/models', "#{file_path}.rb")
    raise "User model (#{model_file}) must exits." unless File.exists?(model_file)
    class_collisions 'Rate'
    template 'model.rb', File.join('app/models', "rate.rb")
    template 'cache_model.rb', File.join('app/models', "rating_cache.rb")
    template 'average_cache_model.rb', File.join('app/models', "average_cache.rb")
    template 'overall_average_model.rb', File.join('app/models', "overall_average.rb")
  end

  def add_rate_path_to_route
    route "post '/rate' => 'rater#create', :as => 'rate'"
  end

  desc "cacheable rating average migration is creating ..."
  def create_cacheable_migration
    migration_template "cache_migration.rb", "db/migrate/create_rating_caches.rb"
  end

  desc "migration is creating ..."
  def create_ratyrate_migration
    migration_template "migration.rb", "db/migrate/create_rates.rb"
  end

  desc "average caches migration is creating ..."
  def create_average_caches_migration
    migration_template "average_cache_migration.rb", "db/migrate/create_average_caches.rb"
  end

  desc "overall averages migration is creating ..."
  def create_overall_averages_migration
    migration_template "overall_average_migration.rb", "db/migrate/create_overall_averages.rb"
  end
end
