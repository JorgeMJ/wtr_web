class MainController < ApplicationController

  before_action :current_custodian # only: [:index, :signin] ??
  def index
    if current_custodian
      redirect_to children_account_path(current_custodian.account_id)
    else
      render :index
    end
  end

  def signin
    options = params.permit(:email, :name)
    custodian = Custodian.find_by(email: options[:email], fname: options[:name])

    if custodian
      reset_session
      session[:current_custodian_id] = custodian.id
      account = Account.find_by(id: custodian.account_id)
    end

    if account
      redirect_to account_path(account)
    else
      redirect_to root_path, notice: "Invalid email or name. Please try again."
    end
  end


end