class CreateTrackedUrls < ActiveRecord::Migration
  def change
    create_table :tracked_urls do |t|
      t.text :long_url, null: false
      t.string :slug, limit: 14, null: false
      t.integer :clicks, default: 0

      t.timestamps null: false
    end
    add_index :tracked_urls, :long_url, unique: true
    add_index :tracked_urls, :slug, unique: true
  end
end
