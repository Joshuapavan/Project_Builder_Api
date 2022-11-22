class RemoveClientIdColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :projects, :client_id
  end
end
