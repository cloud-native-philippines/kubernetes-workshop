json.extract! tweet, :id, :handle, :content, :created_at, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)
