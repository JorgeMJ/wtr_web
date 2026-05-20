class CustodiansController < ApplicationController
  before_action :set_custodian, only: %i[ show edit update destroy ]

  # GET /custodians or /custodians.json
  def index
    @custodians = Custodian.all
  end

  # GET /custodians/1 or /custodians/1.json
  def show
  end

  # GET /custodians/new
  def new
    @custodian = Custodian.new
  end

  # GET /custodians/1/edit
  def edit
  end

  # POST /custodians or /custodians.json
  def create
    @custodian = Custodian.new(custodian_params)

    respond_to do |format|
      if @custodian.save
        format.html { redirect_to @custodian, notice: "Custodian was successfully created." }
        format.json { render :show, status: :created, location: @custodian }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @custodian.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /custodians/1 or /custodians/1.json
  def update
    respond_to do |format|
      if @custodian.update(custodian_params)
        format.html { redirect_to @custodian, notice: "Custodian was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @custodian }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @custodian.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /custodians/1 or /custodians/1.json
  def destroy
    @custodian.destroy!

    respond_to do |format|
      format.html { redirect_to custodians_path, notice: "Custodian was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_custodian
      @custodian = Custodian.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def custodian_params
      params.fetch(:custodian, {})
    end
end
