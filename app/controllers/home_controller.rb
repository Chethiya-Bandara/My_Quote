# purpose: handles requests from the home page
class HomeController < ApplicationController
  def index
    @quotes = Quote.includes(:philosopher).where(is_public: true).order(created_at: :desc).limit(10)
  end
  def uquotes 
    @quotes = Quote.includes(:categories).where(user_id: session[:user_id]) 
  end 
end
