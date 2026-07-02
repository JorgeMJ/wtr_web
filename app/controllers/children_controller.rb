class ChildrenController < ApplicationController
  before_action :is_web_admin, only: %i[ index ]
  before_action :set_account, only: %i[ new create show]
  before_action :set_child, only: %i[ show edit update destroy ]
  after_action :create_nemo_child, only: %i[ create ]
  # after_action :destroy_nemo_child, only: %i[ destroy ]

  # GET /children or /children.json
  def index
    @children = Child.all
  end

  # GET /children/1 or /children/1.json
  def show
    @child = @account.children.find(params[:id])
    # @word = @child.words.new #to set the model of the form "add new word"
    @word = Word.new(child_id: @child.id) 
  end

  # GET /children/new
  def new
    # @child = Child.new
    @child = @account.children.new
  end

  # GET /children/1/edit
  def edit
  end

  def create  
    @child = @account.children.new(child_params)

    if @child.save
      redirect_to children_account_path(@account), notice: "Child created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /children/1 or /children/1.json
  def update
    respond_to do |format|
      if @child.update(child_params)
        format.html { redirect_to @child, notice: "Child was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @child }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /children/1 or /children/1.json
  def destroy
    @account = @child.account
    @child.destroy!

    respond_to do |format|
      format.html { redirect_to children_account_path(@account), status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_child
      @child = Child.find(params[:id])
    end

    def set_account
      @account = Account.find(params[:account_id])
    end

    # Only allow a list of trusted parameters through.
    def child_params
      # params.fetch(:child, {})
      params.require(:child).permit(:name) #Make sure we pass the mandatory params
    end

    def create_nemo_child
      NemoChild.create!(child_id: @child.id)
    end

    # def destroy_nemo_child
    #   NemoChild.find_by(child_id: @child.id)&.destroy
    # end
end
