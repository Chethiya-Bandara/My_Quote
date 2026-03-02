# Purpose: Handles all CRUD operations for quotes, including creation, editing, updating, and deletion, while enforcing login requirements, managing associated philosophers and categories, and ensuring secure parameter handling.

class QuotesController < ApplicationController
  before_action :set_quote, only: %i[ show edit update destroy ]
  before_action :require_login, except: [:index, :show]
  before_action :authorize_edit, only: %i[ edit update ]
  before_action :authorize_delete, only: %i[ destroy ]


  # GET /quotes or /quotes.json
  def index
    #@quotes = Quote.all
    @quotes = current_user.quotes
  end

  # GET /quotes/1 or /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new 
    @quote = Quote.new 
    @quote.build_philosopher
    6.times { @quote.quote_categories.build } # Give the form six category fields to select from
  end 

  # GET /quotes/1/edit
  def edit
    @quote = Quote.find(params[:id])
    @quote.build_philosopher if @quote.philosopher.nil?
  end

  # POST /quotes or /quotes.json
  def create
    @quote = Quote.new(quote_params)
    @quote.user = current_user  # assign current user

    if @quote.philosopher.nil? && (quote_params[:philosopher_attributes].blank? || quote_params[:philosopher_attributes][:fname].blank?)
      @quote.philosopher = Philosopher.find_by(fname: 'Anonymous') || Philosopher.find(1)
    end

    if @quote.categories.empty?
      uncategorized = Category.find_by(name: 'Uncategorized') || Category.find(1)
      @quote.categories << uncategorized if uncategorized
    end

    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: "Quote was successfully created." }
        format.json { render :show, status: :created, location: @quote }
      else
        @quote.quote_categories.build if @quote.quote_categories.empty?
        @quote.build_philosopher if @quote.philosopher.nil?
        6.times { @quote.quote_categories.build }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: "Quote was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy!

    respond_to do |format|
      format.html { redirect_to quotes_path, notice: "Quote was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    def authorize_edit
      unless current_user.is_admin || @quote.user == current_user
        redirect_to quotes_path, alert: "You are not authorized to edit this quote."
      end
    end

    def authorize_delete
      unless current_user.is_admin || @quote.user == current_user
        redirect_to quotes_path, alert: "You are not authorized to delete this quote."
      end
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      params.require(:quote).permit(
        :quote_content, :pub_year, :user_id, :philosopher_id, :comment, :is_public, category_ids: [],
        philosopher_attributes: [:id, :fname, :lname, :birth_year, :death_year, :biography]
        )
    end
end
