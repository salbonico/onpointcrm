class CreateCourses < ActiveRecord::Migration
  def change
  	create_table :courses do |t|
      t.integer :user_id
      t.text :title
      t.text :description
  	end
  end
end
