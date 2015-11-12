class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true
  validates :submitter_id, presence: true

  belongs_to :submitter,
  foreign_key: :submitter_id,
  primary_key: :id,
  class_name: "User"

  has_many :visits,
  foreign_key: :short_url_id,
  primary_key: :id,
  class_name: "Visit"

  has_many :visitors,
  Proc.new { distinct },
  through: :visits,
  source: :user

  has_many :taggings,
    -> { distinct },
    foreign_key: :short_url_id,
    primary_key: :id,
    class_name: "Tagging"

  has_many :tag_topics,
    -> { distinct },
    through: :taggings,
    source: :tag_topics

  def self.random_code
    code = generate_random_code
    while self.exists?(code)
      code = generate_random_code
    end
    @short_url = code
  end

  def self.generate_random_code
    SecureRandom.urlsafe_base64
  end

  def self.create_for_user_and_long_url!(user_id, long_url)
    s = ShortenedUrl.create(submitter_id: user_id, long_url: long_url, short_url: self.random_code)
  end

  def num_clicks
    Visit.select(:short_url_id).where("short_url_id = ?", self.id).count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    Visit.distinct.select(:short_url_id).where("short_url_id = ? AND updated_at > '#{10.minutes.ago}'", self.id).count
  end
end
