class AddConfirmToMembers < ActiveRecord::Migration
  def change
    add_column :members, :confirm, :boolean , default: false
  end
end
