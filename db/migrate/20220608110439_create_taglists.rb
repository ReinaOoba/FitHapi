class CreateTaglists < ActiveRecord::Migration[6.1]
  def change
    create_table :taglists do |t|
      t.integer :tag_id, default: ""
      t.integer :article_id, null: false, default: ""
      t.timestamps
    end

    add_index :Taglists, [:article_id, :tag_id], unique: true
  end
end
