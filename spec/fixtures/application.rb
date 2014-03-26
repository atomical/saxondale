require 'active_support/all'
require 'action_controller'
require 'action_dispatch'
require 'action_pack'
require 'logger'

# http://say26.com/rspec-testing-controllers-outside-of-a-rails-application
module Rails

  def self.cache
    @@cache ||= ActiveSupport::Cache::MemoryStore.new
  end

  class App
    def env_config; {} end
    def routes
      return @routes if defined?(@routes)
      @routes = ActionDispatch::Routing::RouteSet.new
      @routes.draw do
        resources :images do
          member do 
            get :thumbnail
          end
        end # Replace with your own needs
      end
      @routes
    end
  end

  def self.application
    @app ||= App.new
  end
end