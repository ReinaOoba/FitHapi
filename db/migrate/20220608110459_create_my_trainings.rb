class CreateMyTrainings < ActiveRecord::Migration[6.1]
  def change
    create_table :my_trainings do |t|
      t.integer :user_id, null: false, default: ""
      t.string :menu,     null: false, default: ""
      t.string :set,      null: false, default: ""
      t.string :note,     null: false, default: ""
      t.timestamps
    end
  end
end
