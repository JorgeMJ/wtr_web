class ApplicationController < ActionController::Base
  def current_custodian
    @current_custodian ||= Custodian.find_by(id: session[:current_custodian_id]) if session[:current_custodian_id]
  end

  def current_account
    @current_account ||= Account.find_by(id: session[:current_account_id]) if session[:current_account_id]
  end

  def signed_in?
    current_custodian.present?
  end

  def authenticate_custodian!
    redirect_to root_path, notice: "Please sign in." unless signed_in?
  end

  def sign_out_custodian
    session.delete(:current_custodian_id)
    session.delete(:current_account_id)
    reset_session
  end

  def is_web_admin
    is_admin = signed_in? && current_custodian.is_admin

    if !is_admin
      redirect_back(fallback_location: root_path)
    end
  end
  
  # exposes methods
  helper_method :current_custodian, :current_account, :signed_in?, :is_web_admin
end
