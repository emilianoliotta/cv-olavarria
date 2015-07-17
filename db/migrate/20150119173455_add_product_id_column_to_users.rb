class AddProductIdColumnToUsers < ActiveRecord::Migration
  def change
  	add_reference :users, :product, index: true
  end
end
