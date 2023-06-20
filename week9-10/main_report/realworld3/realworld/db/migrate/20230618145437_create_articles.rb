class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.text :body
      t.string :slug

      t.timestamps
    end
  end
end
