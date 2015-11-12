class AddTopicIdToShortenedUrls < ActiveRecord::Migration
  def change
    add_column :shortened_urls, :topic_id, :integer
  end
end
