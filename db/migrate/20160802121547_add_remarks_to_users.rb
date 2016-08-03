class AddRemarksToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remarks, :string
  end
end
