class CreateTaglists < ActiveRecord::Migration[6.1]
  def change
    create_table :taglists do |t|
      t.integer :tag_id
      t.integer :article_id, null: false, default: ""
      t.timestamps
    end
  end
end
