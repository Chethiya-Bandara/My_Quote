json.extract! quote, :id, :quote_content, :pub_year, :is_public, :comment, :user_id, :philosopher_id, :created_at, :updated_at
json.url quote_url(quote, format: :json)
