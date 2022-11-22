class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :description
      t.string :email
      t.string :primary_contact_name

      t.timestamps
    end
  end
end
