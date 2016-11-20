class Admin::WordsController < ApplicationController

  include CategoryUtils

  before_action :logged_in_user, :require_admin
  before_action only: [:create, :update] {
    find_category params[:word][:category_id]}

  def create
    @word = Word.new word_params
    if @word.save
      flash.now[:success] = t "admin.create_new_word_success_msg"
      @new_word = Word.new
      Settings.mininum_answers_count.times {@new_word.answers.build}
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    find_word
    @update_word.update_attributes word_params
    respond_to do |format|
      format.js
    end
  end

  private
  def word_params
    params.require(:word).permit :category_id, :content,
      answers_attributes: [:is_correct, :content, :_destroy, :id]
  end

  def find_word
    @update_word = Word.find_by id: params[:id]
    if @update_word.nil?
      flash[:danger] = t "word_not_found_message"
      redirect_to @category
    end
  end
end
