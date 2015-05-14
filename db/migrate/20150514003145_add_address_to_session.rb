class AddAddressToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :full_street_address, :string
  end
end
