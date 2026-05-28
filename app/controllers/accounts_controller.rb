class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy ]

  # GET /accounts or /accounts.json
  def index
    #Renders all accounts index.html
    #The user shouldn't have access to see all accounts. Only admins
    @accounts = Account.all
  end

  # GET /accounts/1 or /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts or /accounts.json
  def create
    @account = Account.new(account_params)

    if @account.save
      #Create first custodian for the account, which will be the admin custodian
      custodian = @account.custodians.create!(
        fname:  @account.parent_name,
        email: @account.parent_email
      )

      # Set the admin custodian for the account
      @account.update!(admin_custodian_id: custodian.id)

      #TODO: redirecto to @account (is the account we just created):
      #- show id account details
      #- show who is the admin custodian
      #-Add to bttns to redirect to:
      # - "Parent list" and "children list"
      redirect_to @account
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: "Account was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy!

    respond_to do |format|
      format.html { redirect_to accounts_path, notice: "Account was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def children
    @account = Account.find(params[:id])
    @children = @account.children
  end

  def custodians
    @account = Account.find(params[:id])
    @custodians = @account.custodians
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      # params.fetch(:account, {})
      params.require(:account).permit(:parent_name, :parent_email)
    end
end
