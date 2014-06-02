class AddProjectmanagerToMembers < ActiveRecord::Migration
  def change
    add_column :members, :projectmanager, :boolean, default: false
  end
end
