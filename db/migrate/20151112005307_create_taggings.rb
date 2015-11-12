class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :topic_id, null: false
      t.integer :short_url_id, null: false
      t.timestamps
    end
  end
end
