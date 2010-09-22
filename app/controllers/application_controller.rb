class ApplicationController < ActionController::Base
  before_filter :set_body_id
  
  protect_from_forgery
  
  private
    def current_action
      request.path_parameters[:action]
    end
    
    def current_controller
      request.path_parameters[:controller]
    end
    
    def set_body_id     
      @body_id = "#{current_controller}-#{current_action}".gsub("/", "-")
    end
  
end
