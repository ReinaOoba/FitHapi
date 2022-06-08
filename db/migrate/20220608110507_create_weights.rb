class CreateWeights < ActiveRecord::Migration[6.1]
  def change
    create_table :weights do |t|
      t.integer :user_id, null: false, default: ""
      t.integer :record,  null: false, default: ""
      t.timestamps
    end
  end
end
