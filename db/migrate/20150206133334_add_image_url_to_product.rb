class AddImageUrlToProduct < ActiveRecord::Migration
  def change
  	add_column :products, :imageURL, :string
  end
end
