class Tagging < ActiveRecord::Base
  validates :topic_id, presence: true
  validates :short_url_id, presence: true

  belongs_to :tag_topic,
    foreign_key: :topic_id,
    primary_key: :id,
    class_name: "TagTopic"

  belongs_to :shortened_url,
    foreign_key: :short_url_id,
    primary_key: :id,
    class_name: "ShortenedUrl"
end
