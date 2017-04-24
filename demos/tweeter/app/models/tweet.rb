class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :handle, type: String
  field :content, type: String

  after_save do |tweet|

    Rails.logger.debug "Tweet.after_save: tweet => #{tweet.inspect}"
    ActionCable.server.broadcast "tweets", {
      handle: tweet.handle,
      content: tweet.content
    }
  end
end
