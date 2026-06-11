class ApplicationController < ActionController::Base
  def current_custodian
    @current_custodian ||= Custodian.find_by(id: session[:current_custodian_id]) if session[:current_custodian_id]
  end
  
  helper_method :current_custodian
end
