class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.integer :user_id,     null: false, default: ""
      t.integer :category_id, null: false, default: ""
      t.string :title,        null: false, default: ""
      t.text :text,           null: false, default: ""
      t.integer :status,      null: false, default: ""
      t.timestamps
    end
  end
end
