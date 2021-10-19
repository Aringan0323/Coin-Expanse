class CreateNewsArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :news_articles do |t|
      t.string :title
      t.string :name
      t.string :description
      t.string :url
      t.string :image_url
      t.date :date

      t.timestamps
    end
  end
end
