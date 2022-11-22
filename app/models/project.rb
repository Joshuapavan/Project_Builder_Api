class Project < ApplicationRecord
  belongs_to :user
  # belongs_to :client

  validates :name, presence: true, uniqueness: true
  validates :project_type,:manager,:start_date,:user_id,presence: true

end
