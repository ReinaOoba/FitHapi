class CreateWeights < ActiveRecord::Migration[6.1]
  def change
    create_table :weights do |t|
      t.integer :user_id, null: false, default: ""
      t.float :number,  null: false, default: ""
      t.timestamps
    end
  end
end
