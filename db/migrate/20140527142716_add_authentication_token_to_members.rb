class AddAuthenticationTokenToMembers < ActiveRecord::Migration
  def change
    add_column :members, :authentication_token, :string, unique: true
  end
  end
