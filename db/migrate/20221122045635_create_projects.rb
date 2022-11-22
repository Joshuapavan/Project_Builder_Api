class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.string :manager
      t.date :start_date
      t.date :end_date
      t.boolean :closure_status

      t.timestamps
    end
  end
end
