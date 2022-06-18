class CreateTaglists < ActiveRecord::Migration[6.1]
  def change
    create_table :taglists do |t|
      t.integer :tag_id
      t.integer :article_id, null: false
      t.timestamps
    end

    add_index :taglists, [:article_id, :tag_id], unique: true
  end
end
