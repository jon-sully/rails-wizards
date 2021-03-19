class AddCopmletedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :completed, :boolean, null: false, default: false
  end
end
