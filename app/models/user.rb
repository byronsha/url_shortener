class User < ActiveRecord::Base
  validates :email, presence: true

  has_many :submitted_urls,
  foreign_key: :submitter_id,
  primary_key: :id,
  class_name: "ShortenedUrl"

  has_many :visits,
  foreign_key: :user_id,
  primary_key: :id,
  class_name: "Visit"

  has_many :visited_urls,
  -> { distinct },
  through: :visits,
  source: :shortened_url
end
