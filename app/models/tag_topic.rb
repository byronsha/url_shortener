class TagTopic < ActiveRecord::Base
  has_many :taggings,
    foreign_key: :topic_id,
    primary_key: :id,
    class_name: "Tagging"

  has_many :shortened_urls,
    through: :taggings,
    source: :shortened_urls

  def self.most_popular
    ShortenedUrl.num_clicks
    #Visit.distinct.select(:short_url_id).where("short_url_id = ? AND updated_at > '#{10.minutes.ago}'", self.id).count
    end
end
