class AddAddressToShelters < ActiveRecord::Migration[5.2]
  def change
    add_column :shelters, :address, :string
  end
end
