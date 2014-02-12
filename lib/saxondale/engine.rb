module Saxondale
  class Engine < Rails::Engine

    ActiveSupport.on_load :action_controller do |app|
      ActionController::Base.send :include, Saxondale::ControllerMethods
    end

    ActiveFedora::Base.extend Saxondale::ModelMethods
  end
end