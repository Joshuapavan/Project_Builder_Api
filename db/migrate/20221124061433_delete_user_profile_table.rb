class DeleteUserProfileTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_profiles
  end
end
