class RemoveTaglistIdFromArticles < ActiveRecord::Migration[6.1]
  def change
    remove_column :articles, :taglist_id, :integer
  end
end
