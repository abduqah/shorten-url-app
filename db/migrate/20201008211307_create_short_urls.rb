class CreateShortUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :shorten_url_short_urls do |t|
      t.string :url, null: false
      t.string :short_url, unique: true

      t.timestamps
    end
    
    add_index :shorten_url_short_urls, :url
    add_index :shorten_url_short_urls, :short_url, unique: true
  end
end
