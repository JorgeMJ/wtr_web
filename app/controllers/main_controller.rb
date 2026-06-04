class MainController < ApplicationController
  def index
    
  end

  def signin
    options = params.permit(:email, :name)
    custodian = Custodian.find_by(email: options[:email], fname: options[:name])
    account = Account.find_by(id: custodian.account_id) if custodian

    if account
      redirect_to account_path(account)
    else
      redirect_to root_path, notice: "Invalid email or name. Please try again."
    end
  end


end