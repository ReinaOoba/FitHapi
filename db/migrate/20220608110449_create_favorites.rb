class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id, null: false, default: ""
      t.integer :article_id, null: false, default: ""
      t.timestamps
    end
  end
end
