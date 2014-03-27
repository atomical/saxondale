ENV["RAILS_ENV"] = 'test'

require 'debugger'
require 'saxondale/controller_methods'
require 'saxondale/model_methods'
require 'fixtures/application'
require 'fixtures/models'
require 'fixtures/controllers'
require 'rspec/rails'
require 'active_record'


ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'test.db',
  :pool     => 5,
  :timeout  => 3000
)

begin 
  ActiveRecord::Migration.class_eval do
    create_table :images do |t|
      t.timestamps
    end
  end
rescue
end

RSpec.configure do |config|
end