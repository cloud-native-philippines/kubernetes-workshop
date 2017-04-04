class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :handle, type: String
  field :content, type: String

end
