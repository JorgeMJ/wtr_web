class WordsController < ApplicationController
  before_action :set_word, only: %i[ show edit update ]
  after_action :create_nemo_word, only: %i[ create ]
  after_action :destroy_nemo_word, only: %i[ destroy ]  

  # GET /words or /words.json
  def index
    @words = Word.all
  end

  # GET /words/1 or /words/1.json
  def show
  end

  # GET /words/new
  def new
    @word = Word.new
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words or /words.json
  def create
    puts "@@word params: #{word_params.inspect}"
    @word = Word.new(word_params)

    return if @word.word.blank?
    
    respond_to do |format|
      if @word.save
        format.html { redirect_to account_child_path(@word.child.account, @word.child)}
        format.json { render :show, status: :created, location: @word }
      else
        format.html { redirect_to account_child_path(@word.child.account, @word.child), alert: @word.errors.full_messages.to_sentence }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1 or /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: "Word was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1 or /words/1.json
  def destroy
    @word = Word.find(params[:id])
    account_id = @word.child.account.id
    child_id = @word.child.id

    @word.destroy!

    respond_to do |format|
      format.html { redirect_to account_child_path(account_id, child_id), status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def word_params
      params.require(:word).permit(:word, :child_id, :date, :sign)
    end

    def create_nemo_word
      return if @word.word.blank?
      
      nemo_child = NemoChild.find_by(child_id: @word.child.id)
      NemoWord.create!(nemo_child_id: nemo_child.id, word: @word.word, date: @word.date, sign: @word.sign)
    end

    def destroy_nemo_word
      nemo_child = NemoChild.find_by(child_id: @word.child.id)
      nemo_word = NemoWord.find_by(nemo_child_id: nemo_child.id, word: @word.word)
      nemo_word&.destroy
    end
end
