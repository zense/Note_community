class AddMaterialIdToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :material_id, :integer
  end
end
