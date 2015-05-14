class ChangeAddressColumnName < ActiveRecord::Migration
  def change
    remove_column :sessions, :full_street_address
    add_column :sessions, :address, :string
  end
end
