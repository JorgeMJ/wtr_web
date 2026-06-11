class ApplicationController < ActionController::Base
  def current_custodian
    @current_custodian ||= Custodian.find_by(id: session[:current_custodian_id]) if session[:current_custodian_id]
  end

  def signed_in?
    current_custodian.present?
  end

  def authenticate_custodian!
    redirect_to root_path, notice: "Please sign in." unless signed_in?
  end

  def sign_out_custodian
    session.delete(:current_custodian_id)
    reset_session
  end
  
  # exposes methods to views
  helper_method :current_custodian, :signed_in?
end
