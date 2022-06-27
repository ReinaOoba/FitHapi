class CreateWeights < ActiveRecord::Migration[6.1]
  def change
    create_table :weights do |t|
      t.integer :user_id, null: false
      t.float :number,  null: false
      t.timestamps
    end
  end
end
