class CreateWeights < ActiveRecord::Migration[6.1]
  def change
    create_table :weights do |t|
      t.integer :user_id, null: false
      t.integer :record,  null: false
      t.timestamps
    end
  end
end
