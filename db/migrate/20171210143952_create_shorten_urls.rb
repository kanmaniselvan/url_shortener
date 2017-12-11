class CreateShortenUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :shorten_urls do |t|
      t.text :url, null: false
      t.string :short_code, null: false
      t.datetime :last_seen_date
      t.integer :user_id, null: false
      t.integer :redirect_count, null: false, default: 0

      t.timestamps

      t.index :short_code, unique: true
      t.index :user_id
    end
  end
end
