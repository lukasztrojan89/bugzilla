class AddFormOfBoxToStories < ActiveRecord::Migration
  def change
    add_column :stories, :form_of_box, :string, default: 'Icebox'
  end
end
