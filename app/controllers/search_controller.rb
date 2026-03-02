# Purpose: Handles quote searches by category name, retrieving distinct quotes matching the user’s search query through joined category associations.

class SearchController < ApplicationController
  def index
    category_query = params[:category_query] 
      if category_query.present? 
        @quotematch = Quote.joins(:quote_categories, :categories).where("categories.name LIKE ?", "%#{category_query}%").distinct 
    end 
  end
end
