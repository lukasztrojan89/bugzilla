class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :name
      t.string :type_of_story
      t.string :status
      t.string :owner
      t.references :project, index: true
    end
  end
end
