class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author_name
      t.integer :year_published
      t.integer :isbn
      t.string :primary_topic
      t.string :fictionaility

      t.timestamps
    end
  end
end
