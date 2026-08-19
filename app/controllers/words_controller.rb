# Every time we add a new attribute to the word model, we also have to add it to
# the WORD_ATTRIBUTES_LIST and WORD_ATTRIBUTES_MAP constants below.

WORD_ATTRIBUTES_LIST = [:sign]

WORD_ATTRIBUTES_MAP = {
  '0' => {'0' => '0', '1' => '1'} # 0: false, 1: true
}

MAX_NUM_ATTRIBUTES = 20


class WordsController < ApplicationController
  before_action :is_web_admin, only: %i[ index ]
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

  # Use callbacks to share common setup or constraints between actions.
  private def set_word
    @word = Word.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  private def word_params
    options = params.require(:word).permit(:word, :child_id, :date, :sign, :sign_idx)
    encoded_attr = create_encoded_attr(options)
    options[:encoded_attr] = encoded_attr
    
    options
  end

  private def create_nemo_word
    return if @word.word.blank?
    
    nemo_child = NemoChild.find_by(child_id: @word.child.id)
    begin
      NemoWord.create!(nemo_child_id: nemo_child.id, word: @word.word, date: @word.date, sign: @word.sign)
    rescue ActiveRecord::RecordNotUnique => e
      Rails.logger.error "Failed to create NemoWord: #{e.message}"
    end
  end

  private def destroy_nemo_word
    nemo_child = NemoChild.find_by(child_id: @word.child.id)
    nemo_word = NemoWord.find_by(nemo_child_id: nemo_child.id, word: @word.word)
    nemo_word&.destroy
  end

  private def create_encoded_attr(options)
    reminder = MAX_NUM_ATTRIBUTES - WORD_ATTRIBUTES_LIST.length 
    encoded_reminder = '' + '0' * reminder
    acc = "#{options[:word]}:"

    WORD_ATTRIBUTES_LIST.each do |attr|
      curr_attr_idx = options.delete("#{attr}_idx")
      acc += WORD_ATTRIBUTES_MAP[curr_attr_idx][options[attr]]
    end

    encoded_attr_local = acc + encoded_reminder
    encoded_attr_local
  end
end
